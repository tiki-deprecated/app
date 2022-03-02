/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:google_provider/google_provider.dart';
import 'package:httpp/httpp.dart';

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';

class ApiGoogleServiceEmail extends DataFetchInterfaceEmail {
  final Httpp _httpp;

  ApiGoogleServiceEmail(this._httpp);

  @override
  Future<void> fetchInbox(
      {required ApiOAuthModelAccount account,
      DateTime? since,
      required Function(List<ApiEmailMsgModel> messages) onResult,
      required Function() onFinish}) {
    return GoogleProvider.loggedIn(
            email: account.email,
            token: account.accessToken,
            refreshToken: account.refreshToken,
            displayName: account.displayName,
            httpp: _httpp)
        .fetchInbox(
            onResult: (msgIdList) => onResult(msgIdList
                .map((msgId) => ApiEmailMsgModel(extMessageId: msgId))
                .toList()),
            onFinish: onFinish);
  }

  @override
  Future<void> send(
      {required ApiOAuthModelAccount account,
      String? body,
      required String to,
      String? subject,
      Function(bool success)? onResult}) async {
    return GoogleProvider.loggedIn(
            email: account.email,
            token: account.accessToken,
            refreshToken: account.refreshToken,
            displayName: account.displayName,
            httpp: _httpp)
        .sendEmail(body: body, to: to, subject: subject, onResult: onResult);
  }

  @override
  Future<void> fetchMessages(
      {required ApiOAuthModelAccount account,
      required List<String> messageIds,
      required Function(ApiEmailMsgModel message) onResult,
      required Function() onFinish}) async {
    return GoogleProvider.loggedIn(
            email: account.email,
            token: account.accessToken,
            refreshToken: account.refreshToken,
            displayName: account.displayName,
            httpp: _httpp)
        .fetchMessages(
            messageIds: messageIds,
            onResult: (msg) => onResult(ApiEmailMsgModel.fromDynamic(msg)),
            onFinish: onFinish);
  }
}
