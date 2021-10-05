/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

// ignore_for_file: unused_import

import 'dart:convert';

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
import '../data_bkg/data_bkg_interface_email.dart';
import '../data_bkg/data_bkg_interface_provider.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'model/api_google_model_email.dart';

class ApiMicrosoftServiceEmail implements DataBkgInterfaceEmail {
  final ApiMicrosoftModelEmail model;
  final _log = Logger('ApiMicrosoftServiceEmail');

  final ApiOAuthService apiOAuthService;

  String _messagesEndpoint = "https://graph.microsoft.com/v1.0/me/messages";

  String _sendEmailEndpoint = "https://graph.microsoft.com/v1.0/me/sendMail";

  ApiMicrosoftServiceEmail(this.apiOAuthService)
      : this.model = ApiMicrosoftModelEmail();

  @override
  List<String> get labels => this.model.categories;

  @override
  Future<DataBkgModelPage<String>> getList(ApiOAuthModelAccount account,
      {String? label,
      String? from,
      int? afterEpoch,
      int? maxResults = 10,
      String? page = "0"}) async {
    int pageNum = int.parse(page ?? "0");
    List<String> messages = List.empty();
    String query = _buildQuery(
        afterEpoch: afterEpoch,
        from: from,
        page: pageNum,
        maxResults: maxResults!);
    Uri uri = Uri.parse(
        _messagesEndpoint + "?\$select=id,toRecipients&\$filter=$query");
    Response rsp = await this
        .apiOAuthService
        .proxy(
            () => ConfigSentry.http.get(uri,
                headers: HelperApiHeaders(auth: account.accessToken).header),
            account)
        .timeout(Duration(seconds: 10),
            onTimeout: () => throw new http.ClientException(
                'ApiMicrosoftServiceEmail getList timed out'));
    if (HelperApiUtils.is2xx(rsp.statusCode)) {
      Map msgBody = json.decode(rsp.body);
      List messageList = msgBody['value'];
      _log.finest('Got ' + (messageList.length.toString()) + ' messages');
      messages = messageList
          .where((message) =>
              message['id'] != null &&
              _findRecipient(message['toRecipients'], account.email!))
          .map((message) => message['id'] as String)
          .toList();
      page =
          msgBody['@odata.nextLink'] != null ? (pageNum + 1).toString() : null;
    }
    return DataBkgModelPage(next: page, data: messages);
  }

  @override
  Future<ApiEmailMsgModel?> getMessage(
      ApiOAuthModelAccount account, String messageId) async {
    String urlStr = _messagesEndpoint +
        '/$messageId?\$select=internetMessageHeaders,sender,receivedDateTime';
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
                : null,
            unsubscribeMailTo: unsubscribeMailTo,
            email: message['sender']['emailAddress']['address'],
            name: message['sender']['emailAddress']['name']));
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
    if (HelperApiUtils.is2xx(rsp.statusCode)) {
      _log.finest('unsubscribe mail sent to ' + to);
      return true;
    }
    return false;
  }

  String _buildQuery(
      {int? afterEpoch, String? from, int page = 0, int maxResults = 10}) {
    StringBuffer queryBuffer = new StringBuffer();
    int skip = page * maxResults;
    queryBuffer.write("&\$skip=$skip&\$top=$maxResults");
    if (afterEpoch != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(afterEpoch);
      _appendQuery(
          queryBuffer, "receivedDateTime ge ${dateTime.toIso8601String()}");
    }
    if (from != null)
      _appendQuery(queryBuffer, "from/emailAddress/address eq $from");
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

  bool _findRecipient(List recipients, String email) {
    bool found = false;
    recipients.forEach((recipient) {
      if (recipient['emailAddress']["address"] == email) found = true;
    });
    return found;
  }
}
