/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_app_data/api_app_data_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_email.dart';
import '../data_bkg/model/data_bkg_model_page.dart';

class ApiMicrosoftServiceEmail implements DataBkgInterfaceEmail {
  ApiMicrosoftServiceEmail(
      {required ApiOAuthModelAccount account,
      required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : super();

  @override
  Future<DataBkgModelPage<String>> emailFetchList(ApiOAuthModelAccount account,
      {String? query, int? maxResults, String? page, int? retries}) {
    // TODO: implement emailFetchList
    throw UnimplementedError();
  }

  @override
  Future<ApiEmailMsgModel?> emailFetchMessage(
      ApiOAuthModelAccount account, String messageId,
      {String format = '', List<String>? headers}) {
    // TODO: implement emailFetchMessage
    throw UnimplementedError();
  }

  @override
  Future<int?> getLastFetch() {
    // TODO: implement getLastFetch
    throw UnimplementedError();
  }

  @override
  Future<String> getPage() {
    // TODO: implement getPage
    throw UnimplementedError();
  }

  @override
  Future<String> getQuery({bool fetchAll = true, bool force = true}) async {
    // TODO: implement getQuery
    throw UnimplementedError();
  }

  @override
  Future sendRawMessage(ApiOAuthModelAccount account, String getBase64Email) {
    // TODO: implement sendRawMessage
    throw UnimplementedError();
  }

  @override
  Future<void> afterFetchList() {
    // TODO: implement afterFetchList
    throw UnimplementedError();
  }

  get emailProvider => null;
}
