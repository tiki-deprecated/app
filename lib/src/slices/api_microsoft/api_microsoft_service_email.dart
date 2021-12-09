/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

// ignore_for_file: unused_import

import 'dart:convert';

import 'package:app/src/slices/data_fetch/model/data_fetch_model_msg.dart';

import '../api_app_data/model/api_app_data_model.dart';
import '../tiki_http/model/tiki_http_request.dart';
import '../tiki_http/model/tiki_request_type.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../config/config_sentry.dart';
import '../../utils/api/helper_api_headers.dart';
import '../../utils/api/helper_api_utils.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import '../data_fetch/data_fetch_interface_provider.dart';
import '../data_fetch/model/data_fetch_model_page.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import '../tiki_http/tiki_http_client.dart';
import 'model/api_google_model_email.dart';

class ApiMicrosoftServiceEmail extends DataFetchInterfaceEmail {
  final ApiMicrosoftModelEmail model;
  final _log = Logger('ApiMicrosoftServiceEmail');
  final TikiHttpClient tikiHttpClient;
  final ApiOAuthService apiOAuthService;

  String _messagesEndpoint = "https://graph.microsoft.com/v1.0/me/messages";
  String _sendEmailEndpoint = "https://graph.microsoft.com/v1.0/me/sendMail";

  ApiMicrosoftServiceEmail(this.apiOAuthService, this.tikiHttpClient)
      : this.model = ApiMicrosoftModelEmail();

  @override
  Future<void> fetchInbox(ApiOAuthModelAccount account, {
      DateTime? since,
      String? page,
      required Future Function(DataFetchModelPage data) onResult,
      required Future Function(ApiOAuthModelAccount account) onFinish}) async {
    int pageNum = int.parse(page ?? "0");
    _log.finest('Fetch inbox ${account.username} started.');
    List<TikiHttpRequest> requests = List<TikiHttpRequest>.empty(growable: true);
    for(int i = 0; i < 1; i++) {
      int currentPage = pageNum + i;
      String query = _buildQuery(
          page: currentPage,
          maxResults: 1);
      Uri uri = Uri.parse(_messagesEndpoint + "?\$select=id&\$filter=$query");
      TikiHttpRequest tikiHttpRequest = TikiHttpRequest(
          uri: uri,
          type: TikiRequestType.GET,
          headers: HelperApiHeaders(auth: account.accessToken).header);
      tikiHttpRequest.onSuccess = (rsp) async {
        _log.finest('Fetch inbox ${account.username} $currentPage onSuccess callback with ${rsp.statusCode} code.');
        if (TikiHttpClient.isTooManyRequests(rsp.statusCode)){
          int retry = int.parse(rsp.headers.entries.singleWhere((element) => element.key == 'retry-after').value);
          _log.warning('Too many requests. Retry after $retry');
          await Future.delayed(Duration(seconds: retry));
          await tikiHttpClient.request(tikiHttpRequest);
        }
        if (TikiHttpClient.is2xx(rsp.statusCode)) {
          Map msgBody = json.decode(rsp.body);
          List messageList = msgBody['value'];
          if (messageList.isEmpty) {
            _cancelAll(requests);
          } else {
            _log.finest('Got ' + (messageList.length.toString()) + ' messages');
            List<DataFetchModelMsg> messages = messageList
                .where((message) => message['id'] != null)
                .map((message) => DataFetchModelMsg(extMessageId: message['id'], account: account.email))
                .toList();
            int? next = msgBody['@odata.nextLink'] != null
                ? currentPage + 1
                : null;
            DataFetchModelPage data = DataFetchModelPage(
                data: messages, next: next.toString());
            onResult(data);
          }
        }
        if (TikiHttpClient.isUnauthorized(rsp.statusCode)){
          apiOAuthService.refreshToken(account);
          tikiHttpRequest.headers = HelperApiHeaders(auth: account.accessToken).header;
          tikiHttpClient.request(tikiHttpRequest);
        }
        // TODO handle http errors
      };
      tikiHttpRequest.onError((error) {
        _log.finest('Fetch inbox ${account.username} $currentPage onError callback.');
        _log.warning(error);
      });
      requests.add(tikiHttpRequest);
    }
    await Future.wait(requests.map((e) => tikiHttpClient.request(e)));
    _log.finest('Fetch inbox ${account.username} $pageNum finished.');
    onFinish(account);
  }

  @override
  Future<void> fetchMessage(ApiOAuthModelAccount account,
      {required String messageId,
      required Future<void> Function(ApiEmailMsgModel message) onResult}) async {
    String urlStr = _messagesEndpoint +
        '/$messageId?\$select=internetMessageHeaders,from,receivedDateTime,toRecipients';
    Uri uri = Uri.parse(urlStr);
    TikiHttpRequest tikiHttpRequest = TikiHttpRequest(
        uri: uri,
        type: TikiRequestType.GET,
        headers: HelperApiHeaders(auth: account.accessToken).header);
    tikiHttpRequest.onSuccess = (rsp) {
      // TODO handle http errors
      Map<String, dynamic> message = json.decode(rsp.body);
      String? unsubscribeMailTo;
      _log.finest('Fetched message ids: ' + (message['id'] ?? ''));
      if (!_isRecipient(message['toRecipients'], account.email!)) return null;
      if (message['internetMessageHeaders'] != null) {
        message['internetMessageHeaders'].forEach((header) {
          switch (header['name']?.trim()) {
            case 'List-Unsubscribe':
              unsubscribeMailTo = _listUnsubscribeHeader(header['value']);
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
    };
  }

  @override
  Future<ApiEmailMsgModel?> getMessage(
      ApiOAuthModelAccount account, String messageId) async {
    String urlStr = _messagesEndpoint +
        '/$messageId?\$select=internetMessageHeaders,from,receivedDateTime,toRecipients';
    Uri uri = Uri.parse(urlStr);
    Response rsp = await this
        .apiOAuthService
        .proxy(
            () => ConfigSentry.http.get(uri,
                headers: HelperApiHeaders(auth: account.accessToken).header),
            account)
        .timeout(Duration(seconds: 10),
            onTimeout: () => throw new http.ClientException(
                'ApiMicrosoftServiceEmail getList timed out'));
    Map<String, dynamic> message = json.decode(rsp.body);
    String? unsubscribeMailTo;
    _log.finest('Fetched message ids: ' + (message['id'] ?? ''));
    if (!_isRecipient(message['toRecipients'], account.email!)) return null;
    if (message['internetMessageHeaders'] != null) {
      message['internetMessageHeaders'].forEach((header) {
        switch (header['name']?.trim()) {
          case 'List-Unsubscribe':
            unsubscribeMailTo = _listUnsubscribeHeader(header['value']);
            break;
        }
      });
    }
    return ApiEmailMsgModel(
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
            name: message['from']['emailAddress']['name']));
  }

  @override
  Future<bool> send(ApiOAuthModelAccount account, String email, String to,
      String subject) async {
    Map message = {
      "message": {
        "subject": subject,
        "body": {"contentType": "HTML", "content": email},
        "toRecipients": [
          {
            "emailAddress": {"address": to}
          }
        ]
      }
    };
    Uri uri = Uri.parse(_sendEmailEndpoint);
    Response rsp = await this
        .apiOAuthService
        .proxy(
            () => ConfigSentry.http.post(uri,
                headers: HelperApiHeaders(auth: account.accessToken).header,
                body: json.encode(message)),
            account)
        .timeout(Duration(seconds: 10),
            onTimeout: () => throw new http.ClientException(
                'ApiMicrosoftServiceEmail sendEmail timed out'));
    if (TikiHttpClient.is2xx(rsp.statusCode)) {
      _log.finest('unsubscribe mail sent to ' + to);
      return true;
    }
    return false;
  }

  String _buildQuery(
      {int? afterEpoch, String? from, int page = 0, int maxResults = 10}) {
    StringBuffer queryBuffer = new StringBuffer();
    if (afterEpoch != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(afterEpoch);
      _appendQuery(
          queryBuffer, "receivedDateTime ge ${dateTime.toIso8601String()}");
    }
    if (from != null)
      _appendQuery(queryBuffer, "from/emailAddress/address eq '$from'");
    int skip = page * maxResults;
    queryBuffer.write("&\$skip=$skip&\$top=$maxResults");
    return queryBuffer.toString();
  }

  StringBuffer _appendQuery(StringBuffer queryBuffer, String append) {
    if (queryBuffer.isNotEmpty) {
      queryBuffer.write(' and ');
    }
    queryBuffer.write(append);
    return queryBuffer;
  }

  String? _listUnsubscribeHeader(String header) {
    String removeCaret = header.replaceAll('<', '').replaceAll(">", '');
    List<String> splitMailTo = removeCaret.split('mailto:');
    if (splitMailTo.length > 1) return splitMailTo[1].split(',')[0];
  }

  bool _isRecipient(List recipients, String email) {
    bool found = false;
    recipients.forEach((recipient) {
      if (recipient['emailAddress']["address"] == email) found = true;
    });
    return found;
  }

  void _cancelAll(List<TikiHttpRequest> requests) {
    requests.forEach((req) => req.cancel());
  }
}
