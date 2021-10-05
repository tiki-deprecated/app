/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as gapis;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../config/config_sentry.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_email.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import 'model/api_google_model_email.dart';

class ApiGoogleServiceEmail implements DataBkgInterfaceEmail {
  final ApiGoogleModelEmail model;
  final _log = Logger('ApiGoogleServiceEmail');

  ApiGoogleServiceEmail() : this.model = ApiGoogleModelEmail();

  @override
  List<String> get labels => this.model.categories;

  @override
  Future<DataBkgModelPage<String>> getList(ApiOAuthModelAccount account,
      {String? label,
      String? from,
      int? afterEpoch,
      int? maxResults = 100,
      String? page}) async {
    List<String>? messages;
    GmailApi? gmailApi = await _getGmailApi(account);
    ListMessagesResponse? emails = await gmailApi?.users.messages
        .list('me',
            maxResults: maxResults,
            includeSpamTrash: true,
            pageToken: page,
            q: _buildQuery(label: label, from: from, afterEpoch: afterEpoch))
        .timeout(Duration(seconds: 10),
            onTimeout: () => throw new http.ClientException(
                'ApiGoogleServiceEmail getList timed out'));
    _log.finest(
        'Got ' + (emails?.messages?.length.toString() ?? '') + ' messages');
    if (emails != null && emails.messages != null)
      messages = emails.messages!
          .where((message) => message.id != null)
          .map((message) => message.id!)
          .toList();
    return DataBkgModelPage(next: emails?.nextPageToken, data: messages);
  }

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
      if (_checkTo(account.email, message)) {
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
      model.categories
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

  bool _checkTo(String? email, Message message) {
    List<MessagePartHeader>? headers = message.payload?.headers;
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

}
