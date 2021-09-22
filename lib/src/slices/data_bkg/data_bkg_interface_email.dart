/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import 'model/data_bkg_model_page.dart';

abstract class DataBkgInterfaceEmail {
  Future<DataBkgModelPage<String>> emailFetchList(ApiOAuthModelAccount account,
      {String? query, int? maxResults, String? page, int? retries});

  Future<ApiEmailMsgModel?> emailFetchMessage(
      ApiOAuthModelAccount account, String messageId,
      {String format, List<String>? headers});

  Future<dynamic> sendRawMessage(
      ApiOAuthModelAccount account, String getBase64Email);

  Future<String> getQuery({bool fetchAll = true, bool force = true});

  Future<int?> getLastFetch();

  Future<String> getPage();

  Future<void> afterFetchList();
}
