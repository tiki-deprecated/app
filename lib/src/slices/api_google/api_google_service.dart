/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:logging/logging.dart';

import '../../utils/helper_json.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'repository/api_google_repository_info.dart';

class ApiGoogleService {
  final _log = Logger('ApiGoogleService');
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [GmailApi.gmailReadonlyScope, GmailApi.gmailSendScope]);
  final ApiGoogleRepositoryInfo _googleInfoRepository =
      ApiGoogleRepositoryInfo();

  Future<GoogleSignInAccount?> getConnectedUser() =>
      _googleSignIn.signInSilently();

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();

  Future<bool> signOut() async {
    await _googleSignIn.signOut();
    var success = !await _googleSignIn.isSignedIn();
    return success;
  }

  Future<bool> isConnected() => _googleSignIn.isSignedIn();

  Future<List<InfoCarouselCardModel>> gmailInfoCards() async {
    List<dynamic>? infoJson = await _googleInfoRepository.gmail();
    return HelperJson.listFromJson(
        infoJson, (s) => InfoCarouselCardModel.fromJson(s));
  }

  Future<DataBkgModelPage<String>> gmailFetch(
      {String? query,
      String? page,
      int retries = 3,
      int maxResults = 500}) async {
    try {
      return await _gmailFetch(
          query: query, maxResults: maxResults, page: page);
    } catch (e) {
      if (retries > 1)
        return gmailFetch(
            query: query,
            retries: retries - 1,
            page: page,
            maxResults: maxResults);
      rethrow;
    }
  }

  Future<DataBkgModelPage<String>> _gmailFetch(
      {String? query, int? maxResults, String? page}) async {
    GmailApi? gmailApi = await _gmailApi;
    List<String>? messages;
    ListMessagesResponse? emails = await gmailApi?.users.messages.list("me",
        maxResults: maxResults,
        includeSpamTrash: true,
        pageToken: page,
        q: query);
    _log.finest(
        'Fetched ' + (emails?.messages?.length.toString() ?? '') + ' messages');
    if (emails != null && emails.messages != null)
      messages = emails.messages!
          .where((message) => message.id != null)
          .map((message) => message.id!)
          .toList();
    return DataBkgModelPage(next: emails?.nextPageToken, data: messages);
  }

  Future<ApiEmailMsgModel?> gmailFetchMessage(String messageId,
      {String format = "metadata",
      List<String>? headers,
      int retries = 3}) async {
    try {
      return await _gmailFetchMessage(messageId,
          format: format, headers: headers);
    } catch (e) {
      if (retries > 1)
        return gmailFetchMessage(messageId,
            format: format, headers: headers, retries: retries - 1);
      rethrow;
    }
  }

  Future<ApiEmailMsgModel?> _gmailFetchMessage(String messageId,
      {String format = "metadata", List<String>? headers}) async {
    GmailApi? gmailApi = await _gmailApi;
    List<String> metadataHeaders = ["From"];
    metadataHeaders.addAll(headers ?? []);
    Message? message = await gmailApi?.users.messages
        .get("me", messageId, format: format, metadataHeaders: metadataHeaders);
    _log.finest('Fetched message ids: ' + (message?.id ?? ''));
    return message != null ? _convertMessage(message) : null;
  }

  Future<bool> unsubscribe(String unsubscribeMailTo, String list) async {
    GmailApi? gmailApi = await _gmailApi;
    if (gmailApi == null) return false;
    Uri uri = Uri.parse(unsubscribeMailTo);
    String to = uri.path;
    String subject = uri.queryParameters['subject'] ?? "Unsubscribe from $list";
    String email = '''
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
to: $to
from: me
subject: $subject

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
<html xmlns=“https://www.w3.org/1999/xhtml”>
<head>
<title>Test Email Sample</title>
<meta http–equiv=“Content-Type” content=“text/html; charset=UTF-8” />
<meta http–equiv=“X-UA-Compatible” content=“IE=edge” />
<meta name=“viewport” content=“width=device-width, initial-scale=1.0 “ />
</head>
<body class=“em_body” style=“margin:0px; padding:0px;”> 
Hello,<br /><br />
I'd like to stop receiving emails from this email list.<br /><br />
Thanks,<br /><br />
${_googleSignIn.currentUser?.displayName ?? ''}<br />
<br />
*Sent via http://www.mytiki.com. Join the data ownership<br />
revolution today.<br />
</body>
</html>
''';

    await gmailApi.users.messages
        .send(Message.fromJson({'raw': _getBase64Email(source: email)}), "me");
    return true;
  }

  Future<GmailApi?> get _gmailApi async {
    var authClient = await _googleSignIn.authenticatedClient();
    if (authClient != null) {
      return GmailApi(authClient);
    }
    return null;
  }

  String _getBase64Email({String? source}) {
    List<int> bytes = utf8.encode(source ?? '');
    String base64String = base64UrlEncode(bytes);
    return base64String;
  }

  ApiEmailMsgModel _convertMessage(Message message) {
    DateTime? openedDate;
    if (message.labelIds != null) {
      message.labelIds!.forEach((label) {
        if (label.contains("CATEGORY_")) {
          if ("PROMOTION" == label.replaceFirst('CATEGORY_', '')) return null;
        }
      });
      openedDate =
          message.labelIds!.contains("UNREAD") && message.internalDate != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  int.parse(message.internalDate!))
              : null;
    }
    return ApiEmailMsgModel(
        extMessageId: message.id,
        receivedDate: message.internalDate != null
            ? DateTime.fromMillisecondsSinceEpoch(
                int.parse(message.internalDate!))
            : null,
        openedDate: openedDate,
        account: _googleSignIn.currentUser!.email,
        sender: _convertSender(message));
  }

  ApiEmailSenderModel _convertSender(Message message) {
    ApiEmailSenderModel sender = ApiEmailSenderModel();
    List<MessagePartHeader>? headers = message.payload?.headers;
    if (headers != null) {
      for (var headerEntry in headers) {
        switch (headerEntry.name!.trim()) {
          case "From":
            var values = headerEntry.value!.split('<');
            if (values.length == 1)
              sender.email = values[0].trim();
            else if (values.length == 2) {
              sender.name = values[0].trim();
              sender.email = values[1].trim().replaceAll('>', '');
            }
            break;
          case "List-Unsubscribe":
            String removeCaret =
                headerEntry.value!.replaceAll('<', '').replaceAll(">", '');
            List<String> splitMailTo = removeCaret.split('mailto:');
            if (splitMailTo.length > 1)
              sender.unsubscribeMailTo = splitMailTo[1].split(',')[0];
            break;
        }
      }
    }
    if (message.labelIds != null) {
      message.labelIds!.forEach((label) {
        if (label.contains("CATEGORY_"))
          sender.category = label.replaceFirst('CATEGORY_', '');
      });
    }
    return sender;
  }
}
