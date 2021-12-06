/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../api_oauth/api_oauth_service.dart';
import '../tiki_http/model/tiki_http_request.dart';
import '../tiki_http/model/tiki_request_type.dart';
import '../../utils/api/helper_api_headers.dart';
import 'package:collection/collection.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as gapis;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../config/config_sentry.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import '../data_fetch/model/data_fetch_model_page.dart';
import '../tiki_http/tiki_http_client.dart';
import 'model/api_google_model_email.dart';

class ApiGoogleServiceEmail extends DataFetchInterfaceEmail {
  final ApiGoogleModelEmail model;
  final TikiHttpClient _tikiHttpClient;
  final _log = Logger('ApiGoogleServiceEmail');
  final ApiOAuthService apiOAuthService;

  ApiGoogleServiceEmail(this.apiOAuthService, tikiHttpClient)
      : this._tikiHttpClient = tikiHttpClient,
        this.model = ApiGoogleModelEmail();

  String _messagesEndpoint = "https://gmail.googleapis.com/gmail/v1/users/me/messages/";

  @override
  Future<ApiEmailMsgModel?> getMessage(
      ApiOAuthModelAccount account, String messageId) async {
    GmailApi? gmailApi = await _getGmailApi(account);
    if (gmailApi != null) {
      Message? message = await gmailApi.users.messages.get('me', messageId,
          format: 'metadata',
          metadataHeaders: [
            'From',
            'To',
            'List-Unsubscribe'
          ]).timeout(Duration(seconds: 10),
          onTimeout: () =>
              throw new http.ClientException('_gmailFetch timed out'));
      _log.finest('Fetched message ids: ' + (message.id ?? ''));
      if (_checkTo(account.email, json.decode(json.encode(message)))) {
        List<String> from = List.empty(growable: true);
        String? unsubscribeMailTo;
        message.payload?.headers?.forEach((header) {
          switch (header.name?.trim()) {
            case 'From':
              from = _fromEmailHeader(header);
              break;
            case 'List-Unsubscribe':
              unsubscribeMailTo = _listUnsubscribeHeader(header);
              break;
          }
        });
        return ApiEmailMsgModel(
            extMessageId: message.id,
            receivedDate: message.internalDate != null
                ? DateTime.fromMillisecondsSinceEpoch(
                    int.parse(message.internalDate!))
                : null,
            openedDate: _openDate(message),
            account: account.email,
            sender: ApiEmailSenderModel(
              category: _categoryHeader(message.labelIds),
              unsubscribeMailTo: unsubscribeMailTo,
              email: from.isNotEmpty ? from[0] : null,
              name: from.length >= 2 ? from[1] : null,
            ));
      }
    }
  }

  @override
  Future<bool> send(ApiOAuthModelAccount account, String email, String to,
      String subject) async {
    GmailApi? gmailApi = await _getGmailApi(account);
    String message = '''
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
to: $to
from: me
subject: $subject

$email
''';
    String base64Email = base64UrlEncode(utf8.encode(message));
    if (gmailApi != null) {
      await gmailApi.users.messages
          .send(Message.fromJson({'raw': base64Email}), 'me');
      return true;
    }
    return false;
  }

  Future<GmailApi?> _getGmailApi(ApiOAuthModelAccount account) async {
    if (account.accessToken != null) {
      String token = account.accessToken!;
      DateTime tokenExp = account.accessTokenExpiration != null
          ? DateTime.fromMillisecondsSinceEpoch(account.accessTokenExpiration!)
              .toUtc()
          : DateTime.now().toUtc().add(const Duration(days: 365));
      gapis.AccessToken accessToken =
          gapis.AccessToken('Bearer', token, tokenExp);
      List<String> scopes = [
        'openid',
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/gmail.readonly',
        'https://www.googleapis.com/auth/gmail.send'
      ];
      gapis.AccessCredentials credentials =
          gapis.AccessCredentials(accessToken, account.refreshToken, scopes);
      gapis.AuthClient authClient =
          gapis.authenticatedClient(ConfigSentry.http, credentials);
      return GmailApi(authClient);
    }
  }

  String _buildQuery({int? afterEpoch, String? label, String? from}) {
    StringBuffer queryBuffer = new StringBuffer();
    if (afterEpoch != null) {
      int secondsSinceEpoch = (afterEpoch / 1000).floor();
      _appendQuery(queryBuffer, 'after:' + secondsSinceEpoch.toString());
    }
    if (label != null && label.isNotEmpty && label != 'category:') {
      _appendQuery(queryBuffer, label);
    } else if (from == null) {
      ApiGoogleModelEmail.categories
          .where((cat) => cat != 'category:')
          .forEach((cat) => _appendQuery(queryBuffer, 'NOT $cat'));
    }
    if (from != null) _appendQuery(queryBuffer, 'from:' + from);
    return queryBuffer.toString();
  }

  StringBuffer _appendQuery(StringBuffer queryBuffer, String append) {
    if (queryBuffer.isNotEmpty) {
      queryBuffer.write(' AND ');
    }
    queryBuffer.write(append);
    return queryBuffer;
  }

  bool _checkTo(String? email, Map message) {
    List<MessagePartHeader>? headers = message['payload']['headers'];
    if (email == null || headers == null || headers.isEmpty) return false;
    MessagePartHeader? toHeader =
        headers.firstWhereOrNull((header) => header.name?.trim() == "To");
    if (toHeader == null || toHeader.value == null) return false;
    String toHeaderEmail = toHeader.value!.contains("<")
        ? toHeader.value!.split("<").toList()[1].replaceFirst(">", "").trim()
        : toHeader.value!;
    if (email.toLowerCase() != toHeaderEmail.trim().toLowerCase()) return false;
    return true;
  }

  DateTime? _openDate(Message message) {
    //TODO implement this correctly.
    /*DateTime? openedDate;
    if (message.labelIds != null) {
      return !message.labelIds!.contains("UNREAD") &&
              message.internalDate != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.parse(message.internalDate!))
          : null;
    }*/
  }

  List<String> _fromEmailHeader(MessagePartHeader header) {
    List<String> rsp = List.empty(growable: true);
    if (header.value != null) {
      List<String> values = header.value!.split('<');
      if (values.length == 1)
        rsp.add(values[0].trim());
      else if (values.length == 2) {
        rsp.add(values[1].trim().replaceAll('>', ''));
        rsp.add(values[0].trim().replaceAll("\"", ''));
      }
    }
    return rsp;
  }

  String? _listUnsubscribeHeader(MessagePartHeader header) {
    if (header.value != null) {
      String removeCaret =
          header.value!.replaceAll('<', '').replaceAll(">", '');
      List<String> splitMailTo = removeCaret.split('mailto:');
      if (splitMailTo.length > 1) return splitMailTo[1].split(',')[0];
    }
  }

  String? _categoryHeader(List<String>? labelIds) {
    if (labelIds != null) {
      String? categoryLabel =
          labelIds.firstWhereOrNull((label) => label.contains("CATEGORY_"));
      if (categoryLabel != null)
        return categoryLabel.replaceFirst('CATEGORY_', '');
    }
  }

  @override
  Future<void> fetchInbox(ApiOAuthModelAccount account, {
    DateTime? since,
    String? page,
    required Future Function(DataFetchModelPage data) onResult,
    required Future Function(ApiOAuthModelAccount account) onFinish}) async {
    String? pageToken = page;
    _log.finest('Fetch inbox ${account.username} started.');
    int? afterEpoch = since != null ? (since.millisecondsSinceEpoch / 1000)
        .round() : null;
    String query = _buildQuery(afterEpoch: afterEpoch);
    _fetchPage(
        account: account,
        query: query,
        pageToken: pageToken,
        onResult: onResult,
        onFinish: onFinish
    );
  }

  Future<void> _fetchPage({
    required ApiOAuthModelAccount account,
    required String query,
    String? pageToken,
    required Future Function(DataFetchModelPage data) onResult,
    required Future Function(ApiOAuthModelAccount account) onFinish}) async {
    String pageQuery = pageToken == null ? '' : 'pageToken=$pageToken';
    Uri uri = Uri.parse(_messagesEndpoint + "?$pageQuery&q=$query");
    TikiHttpRequest tikiHttpRequest = TikiHttpRequest(
        uri: uri,
        type: TikiRequestType.GET,
        headers: HelperApiHeaders(auth: account.accessToken).header);
    tikiHttpRequest.onSuccess = (rsp) async {
      _log.finest('Fetch inbox ${account.username} $pageQuery onSuccess callback with ${rsp.statusCode} code.');
      if (TikiHttpClient.is2xx(rsp.statusCode)) {
        Map msgBody = json.decode(rsp.body);
        List messageList = msgBody['messages'];
        _log.finest('Got ' + (messageList.length.toString()) + ' messages');
        List<ApiEmailMsgModel> messages = messageList
            .where((message) => message['id'] != null)
            .map((message) =>
            ApiEmailMsgModel(
                extMessageId: message['id'], account: account.email))
            .toList();
        String? next = msgBody['nextMessageToken'];
        DataFetchModelPage data = DataFetchModelPage(
            data: messages, next: next.toString());
        onResult(data);
        if(next != null) {
          _log.finest('Fetch page $pageToken finished.');
          _fetchPage(account: account, pageToken: next, query: query, onResult: onResult, onFinish: onFinish);
        }else{
          _log.finest('Fetch inbox ${account.username} finished.');
          onFinish(account);
        }
      }
      if (TikiHttpClient.isUnauthorized(rsp.statusCode)){
        apiOAuthService.refreshToken(account);
        tikiHttpRequest.headers = HelperApiHeaders(auth: account.accessToken).header;
        _tikiHttpClient.request(tikiHttpRequest);
      }
      // TODO handle http errors
    };
    tikiHttpRequest.onError((error) {
      _log.finest('Fetch inbox ${account.username} $pageToken onError callback.');
      _log.warning(error);
    });
    _tikiHttpClient.request(tikiHttpRequest);
  }

  @override
  Future<void> fetchMessage(ApiOAuthModelAccount account,
      {required String messageId,
        required Future<void> Function(ApiEmailMsgModel message) onResult}) async {
    String format = 'metadata';
    String metadataHeaders = 'From,To,List-Unsubscribe';
    String urlStr = '$_messagesEndpoint$messageId?format=$format&metadataHeaders=$metadataHeaders';
    Uri uri = Uri.parse(urlStr);
    TikiHttpRequest tikiHttpRequest = TikiHttpRequest(
        uri: uri,
        type: TikiRequestType.GET,
        headers: HelperApiHeaders(auth: account.accessToken).header);
    tikiHttpRequest.onSuccess = (rsp) {
      // TODO handle http errors
      Map<String, dynamic> message = json.decode(rsp.body);
      _log.finest('Fetched message ids: ' + (message['id'] ?? ''));
      if (!_checkTo(account.email!, message)) return null;
      if (_checkTo(account.email, json.decode(json.encode(message)))) {
        List<String> from = List.empty(growable: true);
        String? unsubscribeMailTo;
        if (message['internetMessageHeaders'] != null) {
          message['internetMessageHeaders'].forEach((header) {
            switch (header['name']?.trim()) {
              case 'From':
                from = _fromEmailHeader(header);
                break;
              case 'List-Unsubscribe':
                unsubscribeMailTo = _listUnsubscribeHeader(header);
                break;
            }
          });
        }
        onResult(ApiEmailMsgModel(
            extMessageId: messageId,
            receivedDate: DateTime.parse(message['receivedDateTime']),
            openedDate: null,
            // TODO implement opened date
            account: account.email,
            sender: ApiEmailSenderModel(
                category: message['categories'] != null &&
                    message['categories'].isNotEmpty
                    ? message['categories'][0]
                    : "Inbox",
                unsubscribeMailTo: unsubscribeMailTo,
                email: message['from']['emailAddress']['address'],
                name: message['from']['emailAddress']['name']))
        );
      }
    };
    _tikiHttpClient.request(tikiHttpRequest);
  }
}
