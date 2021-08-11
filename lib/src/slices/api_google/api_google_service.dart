/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/slices/api_email_msg/model/api_email_msg_model.dart';
import 'package:app/src/slices/api_email_sender/model/api_email_sender_model.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:logging/logging.dart';

import '../../utils/helper_json.dart';
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

  Future<Set<String>> gmailFetch({String? query}) async {
    return _gmailFetch(messageIds: Set(), query: query);
  }

  Future<Set<String>> _gmailFetch(
      {required Set<String> messageIds,
      String? query,
      int? maxResults,
      String? pageToken}) async {
    GmailApi? gmailApi = await _gmailApi;
    ListMessagesResponse? emails = await gmailApi?.users.messages.list("me",
        maxResults: maxResults,
        includeSpamTrash: true,
        pageToken: pageToken,
        q: query);
    _log.finest(
        'Fetched ' + (emails?.messages?.length.toString() ?? '') + ' messages');
    if (emails != null && emails.messages != null)
      messageIds.addAll(emails.messages!
          .where((message) => message.id != null)
          .map((message) => message.id!)
          .toSet());
    if (emails?.nextPageToken != null)
      return await _gmailFetch(
          messageIds: messageIds,
          query: query,
          maxResults: maxResults,
          pageToken: emails?.nextPageToken);
    else
      return messageIds;
  }

  Future<ApiEmailMsgModel?> gmailFetchMessage(String messageId,
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

Content-Type: text/plain; charset="UTF-8"

Hello,

I'd like to stop receiving emails from this email list.

Thanks,
${_googleSignIn.currentUser?.displayName ?? ''}

*Sent via <a href="http://www.mytiki.com>TIKI</a>. Join the data ownership
revolution today.
''';

    await gmailApi.users.messages.send(
        Message.fromJson({
          'raw': _getBase64Email(source: email),
        }),
        "me");
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
    message.labelIds!.forEach((label) {
      if (label.contains("CATEGORY_")) {
        if ("PROMOTION" == label.replaceFirst('CATEGORY_', '')) return null;
      }
    });
    return ApiEmailMsgModel(
        extMessageId: message.id,
        receivedDate: message.internalDate != null
            ? DateTime.fromMillisecondsSinceEpoch(
                int.parse(message.internalDate!))
            : null,
        openedDate: !message.labelIds!.contains("UNREAD") &&
                message.internalDate != null
            ? DateTime.fromMillisecondsSinceEpoch(
                int.parse(message.internalDate!))
            : null,
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
            String s =
                headerEntry.value!.replaceAll('<', '').replaceAll(">", '');
            List<String> unsubscribeMailToArr = s.split('mailto:');
            sender.unsubscribeMailTo = unsubscribeMailToArr.length > 1
                ? unsubscribeMailToArr[1]
                : unsubscribeMailToArr[0];
            break;
        }
      }
    }
    message.labelIds!.forEach((label) {
      if (label.contains("CATEGORY_"))
        sender.category = label.replaceFirst('CATEGORY_', '');
    });
    return sender;
  }
}
