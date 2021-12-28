/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import 'api_microsoft_service_email_paginator.dart';
import 'model/api_microsoft_model_header.dart';
import 'model/api_microsoft_model_message.dart';
import 'model/api_microsoft_model_recipient.dart';
import 'repository/api_microsoft_repository_email.dart';

class ApiMicrosoftServiceEmail extends DataFetchInterfaceEmail {
  final _log = Logger('ApiMicrosoftServiceEmail');

  final ApiMicrosoftRepositoryEmail _repositoryEmail;
  final ApiOAuthService apiOAuthService;
  final Httpp _httpp;

  ApiMicrosoftServiceEmail(this.apiOAuthService, this._httpp)
      : _repositoryEmail = ApiMicrosoftRepositoryEmail();

  @override
  Future<void> fetchInbox(
      {required ApiOAuthModelAccount account,
      DateTime? since,
      required Function(List<ApiEmailMsgModel> messages) onResult,
      required Function() onFinish}) async {
    HttppClient client = _httpp.client(onFinish: onFinish);
    return ApiMicrosoftServiceEmailPaginator(
            httppClient: client,
            repositoryEmail: _repositoryEmail,
            onSuccess: onResult,
            onResult: (response) {
              _handleUnauthorized(client, response, account);
              _handleTooManyRequests(client, response);
            },
            since: since,
            account: account,
            onFinish: onFinish)
        .fetchInbox();
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
          ApiMicrosoftModelMessage message =
              ApiMicrosoftModelMessage.fromJson(response.body?.jsonBody);
          onResult(ApiEmailMsgModel(
              extMessageId: message.id,
              receivedDate: message.receivedDateTime,
              openedDate: null, //TODO implement open date detection
              account:
                  _accountFromRecipients(message.toRecipients, account.email!),
              sender: ApiEmailSenderModel(
                  email: message.from?.emailAddress?.address,
                  name: message.from?.emailAddress?.name,
                  category: 'inbox',
                  unsubscribeMailTo:
                      _unsubscribeMailTo(message.internetMessageHeaders))));
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

  @override
  Future<void> send(
      {required ApiOAuthModelAccount account,
      String? body,
      required String to,
      String? subject,
      Function(bool success)? onResult}) async {
    HttppClient client = _httpp.client();
    return _repositoryEmail.send(
        client: client,
        accessToken: account.accessToken,
        message: HttppBody.fromJson({
          'message': {
            'subject': subject,
            'body': {'contentType': 'HTML', 'content': body},
            'toRecipients': [
              {
                'emailAddress': {'address': to}
              }
            ]
          }
        }),
        onSuccess: (response) {
          _log.finest('unsubscribe mail sent to ' + to);
          if (onResult != null) onResult(true);
        },
        onResult: (response) {
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

  String? _unsubscribeMailTo(List<ApiMicrosoftModelHeader>? headers) {
    if (headers != null) {
      for (ApiMicrosoftModelHeader header in headers) {
        if (header.name?.trim() == 'List-Unsubscribe') {
          if (header.value != null) {
            String removeCaret =
                header.value!.replaceAll('<', '').replaceAll('>', '');
            List<String> splitMailTo = removeCaret.split('mailto:');
            if (splitMailTo.length > 1) return splitMailTo[1].split(',')[0];
          }
        }
      }
    }
  }

  String? _accountFromRecipients(
      List<ApiMicrosoftModelRecipient>? recipients, String expected) {
    if (recipients == null || recipients.length == 0) return expected;
    for (ApiMicrosoftModelRecipient recipient in recipients) {
      if (recipient.emailAddress?.address == expected) return expected;
    }
    return recipients[0].emailAddress?.address;
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
    if (HttppUtils.isTooManyRequests(response.statusCode)) {
      Duration retry = Duration(seconds: 1);
      if (response.headers != null) {
        double milli = int.parse(response.headers!.map.entries
                .singleWhere((element) => element.key == 'retry-after')
                .value) *
            1100;
        retry = Duration(milliseconds: milli.round());
      }
      _log.warning('Too many requests. Retry after $retry');
      client.denyFor(response.request!, retry);
    }
  }
}
