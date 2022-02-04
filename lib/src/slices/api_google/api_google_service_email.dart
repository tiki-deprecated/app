/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:collection/src/iterable_extensions.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../api_company/api_company_service.dart';
import '../api_company/model/api_company_model.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import 'model/api_google_model_error.dart';
import 'model/api_google_model_header.dart';
import 'model/api_google_model_message.dart';
import 'model/api_google_model_messages.dart';
import 'repository/api_google_repository_email.dart';

class ApiGoogleServiceEmail extends DataFetchInterfaceEmail {
  final _log = Logger('ApiGoogleServiceEmail');

  final Httpp _httpp;
  final ApiOAuthService apiOAuthService;
  final ApiGoogleRepositoryEmail _repositoryEmail;

  ApiGoogleServiceEmail(this.apiOAuthService, this._httpp)
      : _repositoryEmail = ApiGoogleRepositoryEmail();

  @override
  Future<void> fetchInbox(
      {required ApiOAuthModelAccount account,
      DateTime? since,
      required Function(List<ApiEmailMsgModel> messages) onResult,
      required Function() onFinish}) {
    HttppClient httppClient = _httpp.client(onFinish: onFinish);
    return _fetchInbox(
        client: httppClient,
        account: account,
        onResult: onResult,
        since: since);
  }

  @override
  Future<void> send(
      {required ApiOAuthModelAccount account,
      String? body,
      required String to,
      String? subject,
      Function(bool success)? onResult}) async {
    String message = '''
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
to: $to
from: me
subject: $subject
    
$body
''';
    String base64Email = base64UrlEncode(utf8.encode(message));
    HttppClient client = _httpp.client();
    return _repositoryEmail.send(
        client: client,
        accessToken: account.accessToken,
        message: HttppBody.fromJson(
            ApiGoogleModelMessage(raw: base64Email).toJson()),
        onSuccess: (response) {
          _log.finest('unsubscribe mail sent to ' + to);
          if (onResult != null) onResult(true);
        },
        onResult: (response) async {
          _log.warning('unsubscribe for ${to} failed.');
          _handleUnauthorized(client, response, account);
          _handleTooManyRequests(client, response);
          if (onResult != null) onResult(false);
        },
        onError: (error) {
          _log.warning('unsubscribe for ${to} failed.');
          if (onResult != null) onResult(false);
        });
  }

  @override
  Future<void> fetchMessages(
      {required ApiOAuthModelAccount account,
      required List<String> messageIds,
      required Function(ApiEmailMsgModel message) onResult,
      required Function() onFinish}) async {
    HttppClient client = _httpp.client(onFinish: onFinish);
    List<Future> futures = [];
    messageIds.forEach((messageId) => futures.add(_repositoryEmail.message(
        client: client,
        accessToken: account.accessToken,
        messageId: messageId,
        onSuccess: (response) {
          ApiGoogleModelMessage message =
              ApiGoogleModelMessage.fromJson(response.body?.jsonBody);
          Map<String, String>? from = _from(message.payload?.headers);
          onResult(ApiEmailMsgModel(
              extMessageId: message.id,
              receivedDate: message.internalDate,
              openedDate: null, //TODO implement open date detection
              toEmail: _toEmail(message.payload?.headers, account.email!),
              sender: ApiEmailSenderModel(
                  email: from?['email'],
                  name: from?['name'],
                  category: _category(message.labelIds),
                  unsubscribeMailTo:
                      _unsubscribeMailTo(message.payload?.headers),
                  unsubscribed: false,
                  company: ApiCompanyModel(
                      domain:
                          ApiCompanyService.domainFromEmail(from?['email'])))));
        },
        onResult: (response) {
          _log.warning(
              'Fetch message ${messageId} failed with statusCode ${response.statusCode}');
          _handleUnauthorized(client, response, account);
          _handleTooManyRequests(client, response);
        },
        onError: (error) {
          _log.warning('Fetch message ${messageId} failed with error ${error}');
        })));
    await Future.wait(futures);
  }

  Future<void> _fetchInbox(
      {required HttppClient client,
      required ApiOAuthModelAccount account,
      String? pageToken,
      DateTime? since,
      required Function(List<ApiEmailMsgModel> messages) onResult}) {
    return _repositoryEmail.messageId(
      client: client,
      accessToken: account.accessToken,
      filter: _buildFiler(after: since, maxResults: 500, pageToken: pageToken),
      onSuccess: (response) {
        ApiGoogleModelMessages messages =
            ApiGoogleModelMessages.fromJson(response.body?.jsonBody);

        if (messages.nextPageToken != null)
          _fetchInbox(
              client: client,
              account: account,
              onResult: onResult,
              pageToken: messages.nextPageToken,
              since: since);

        onResult(messages.messages
                ?.map((m) => ApiEmailMsgModel(extMessageId: m.id))
                .toList() ??
            List.empty());
      },
      onResult: (response) {
        _log.warning(
            'Fetch inbox ${account.username} failed with statusCode ${response.statusCode}');
        _handleUnauthorized(client, response, account);
        _handleTooManyRequests(client, response);
      },
      onError: (error) => _log.warning(
          'Fetch inbox ${account.username} failed with error ${error}'),
    );
  }

  Map<String, String>? _from(List<ApiGoogleModelHeader>? headers) {
    if (headers != null) {
      for (ApiGoogleModelHeader header in headers) {
        if (header.name?.trim() == 'From') {
          Map<String, String> rsp = Map();
          if (header.value != null) {
            List<String> values = header.value!.split('<');
            if (values.length == 1)
              rsp['email'] = values[0].trim();
            else if (values.length == 2) {
              rsp['email'] = values[1].trim().replaceAll('>', '');
              rsp['name'] = values[0].trim().replaceAll("\"", '');
            }
          }
          return rsp;
        }
      }
    }
  }

  String? _unsubscribeMailTo(List<ApiGoogleModelHeader>? headers) {
    if (headers != null) {
      for (ApiGoogleModelHeader header in headers) {
        if (header.name?.trim() == 'List-Unsubscribe' && header.value != null) {
          String removeCaret =
              header.value!.replaceAll('<', '').replaceAll(">", '');
          List<String> splitMailTo = removeCaret.split('mailto:');
          if (splitMailTo.length > 1) return splitMailTo[1].split(',')[0];
        }
      }
    }
  }

  String? _category(List<String>? labelIds) {
    if (labelIds != null) {
      String? categoryLabel =
          labelIds.firstWhereOrNull((label) => label.contains("CATEGORY_"));
      if (categoryLabel != null)
        return categoryLabel.replaceFirst('CATEGORY_', '');
    }
  }

  String? _toEmail(List<ApiGoogleModelHeader>? headers, String expected) {
    if (headers != null) {
      for (ApiGoogleModelHeader header in headers) {
        if (header.name?.trim() == 'To' && header.value != null) {
          String headerEmail = header.value!.contains("<")
              ? header.value!
                  .split("<")
                  .toList()[1]
                  .replaceFirst(">", "")
                  .trim()
              : header.value!;
          return headerEmail.trim().toLowerCase();
        }
      }
    }
    return expected;
  }

  String _buildFiler(
      {DateTime? after, int maxResults = 500, String? pageToken}) {
    StringBuffer queryBuffer = new StringBuffer();

    _appendQuery(queryBuffer, 'maxResults=$maxResults');

    if (pageToken != null) _appendQuery(queryBuffer, 'pageToken=$pageToken');

    if (after != null) {
      int secondsSinceEpoch = (after.millisecondsSinceEpoch / 1000).floor();
      _appendQuery(queryBuffer, 'q=after:' + secondsSinceEpoch.toString());
    }
    return queryBuffer.toString();
  }

  StringBuffer _appendQuery(StringBuffer queryBuffer, String append) {
    if (queryBuffer.isNotEmpty) {
      queryBuffer.write('&');
    }
    queryBuffer.write(append);
    return queryBuffer;
  }

  void _handleUnauthorized(HttppClient client, HttppResponse response,
      ApiOAuthModelAccount account) {
    if (HttppUtils.isUnauthorized(response.statusCode)) {
      _log.warning('Unauthorized. Trying refresh');
      client.denyUntil(response.request!, () async {
        ApiOAuthModelAccount? refreshed =
            await apiOAuthService.refreshToken(account);
        response.request?.headers?.auth(refreshed?.accessToken);
      });
    }
  }

  void _handleTooManyRequests(HttppClient client, HttppResponse response) {
    if (HttppUtils.isForbidden(response.statusCode)) {
      ApiGoogleModelError error =
          ApiGoogleModelError.fromJson(response.body?.jsonBody['error']);
      error.errors?.forEach((error) {
        if (error.reason == 'rateLimitExceeded') {
          _log.warning('Too many requests. Retry after');
          client.denyFor(response.request!, Duration(seconds: 1));
          return;
        }
      });
    }
  }
}
