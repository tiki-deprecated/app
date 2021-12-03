/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/data_fetch/model/data_fetch_model_msg.dart';

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import 'model/data_fetch_model_page.dart';

abstract class DataFetchInterfaceEmail {
  Future<void> fetchInbox(ApiOAuthModelAccount account,
      {DateTime? since,
      required Future Function(DataFetchModelPage data) onResult,
      required Future Function(ApiOAuthModelAccount account) onFinish});

  Future<void> fetchMessages(ApiOAuthModelAccount account,
      {required List<DataFetchModelMsg> messages,
      required Future Function(ApiEmailMsgModel message) onResult,
      required Future Function(ApiOAuthModelAccount account)
          onFinish}) async {
      await Future.wait(messages.map( (message) {
        ApiEmailMsgModel messageToFetch = ApiEmailMsgModel(extMessageId: message.extMessageId);
        return fetchMessage(account, message: messageToFetch, onResult: onResult);
      }));
      onFinish(account);
  }

  Future<void> fetchMessage(ApiOAuthModelAccount account,
      {required ApiEmailMsgModel message,
      required Future Function(ApiEmailMsgModel message) onResult});

  Future<ApiEmailMsgModel?> getMessage(
      ApiOAuthModelAccount account, String messageId);

  Future<bool> send(
      ApiOAuthModelAccount account, String email, String to, String subject);

}
