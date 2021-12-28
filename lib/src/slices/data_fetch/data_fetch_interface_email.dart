/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';

abstract class DataFetchInterfaceEmail {
  Future<void> fetchInbox(
      {required ApiOAuthModelAccount account,
      DateTime? since,
      required Function(List<ApiEmailMsgModel> messages) onResult,
      required Function() onFinish});

  Future<void> fetchMessages(
      {required ApiOAuthModelAccount account,
      required List<String> messageIds,
      required Function(ApiEmailMsgModel message) onResult,
      required Function() onFinish});

  Future<void> send(
      {required ApiOAuthModelAccount account,
      String? body,
      required String to,
      String? subject,
      Function(bool success)? onResult});
}
