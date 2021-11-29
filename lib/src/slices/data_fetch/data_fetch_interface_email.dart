/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import 'model/data_fetch_model_page.dart';

abstract class DataFetchInterfaceEmail {
  Future<void> fetchInbox(ApiOAuthModelAccount account,
      {DateTime? since,
      required Future<void> Function(List<ApiEmailMsgModel> messages) onResult,
      required Future<void> Function(ApiOAuthModelAccount account) onFinish});

  Future<void> fetchMessages(ApiOAuthModelAccount account,
      {required List<ApiEmailMsgModel> messages,
      required Future<void> Function(ApiEmailMsgModel message) onResult,
      required Future<void> Function(ApiOAuthModelAccount account)
          onFinish}) async {
    await Future.wait(messages.map((message) =>
        fetchMessage(account, message: message, onResult: onResult)));
    onFinish(account);
  }

  Future<void> fetchMessage(ApiOAuthModelAccount account,
      {required ApiEmailMsgModel message,
      required Future<void> Function(ApiEmailMsgModel message) onResult});

  Future<ApiEmailMsgModel?> getMessage(
      ApiOAuthModelAccount account, String messageId);

  Future<bool> send(
      ApiOAuthModelAccount account, String email, String to, String subject);

  @Deprecated('Use the new asyncIndex flow. To be removed in 0.2.9')
  List<String> get labels;

  @Deprecated('Use the new asyncIndex flow. To be removed in 0.2.9')
  Future<DataFetchModelPage<String>> getList(ApiOAuthModelAccount account,
      {String? label,
      String? from,
      int? afterEpoch,
      int? maxResults,
      String? page});
}
