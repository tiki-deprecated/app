/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import 'model/data_fetch_model_page.dart';

abstract class DataFetchInterfaceEmail {
  List<String> get labels;

  Future<ApiEmailMsgModel?> getMessage(
      ApiOAuthModelAccount account, String messageId);

  Future<DataFetchModelPage<String>> getList(ApiOAuthModelAccount account,
      {String? label,
      String? from,
      int? afterEpoch,
      int? maxResults,
      String? page});

  Future<bool> send(
      ApiOAuthModelAccount account, String email, String to, String subject);
}
