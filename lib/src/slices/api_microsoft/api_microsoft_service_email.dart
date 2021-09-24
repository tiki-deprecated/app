/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

// ignore_for_file: unused_import

import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_email.dart';
import '../data_bkg/data_bkg_interface_provider.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';

class ApiMicrosoftServiceEmail implements DataBkgInterfaceEmail {
  @override
  Future<DataBkgModelPage<String>> getList(ApiOAuthModelAccount account,
      {String? label,
      String? from,
      int? afterEpoch,
      int? maxResults,
      String? page}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<ApiEmailMsgModel?> getMessage(
      ApiOAuthModelAccount account, String messageId) {
    // TODO: implement getMessage
    throw UnimplementedError();
  }

  @override
  // TODO: implement labels
  List<String> get labels => throw UnimplementedError();

  @override
  Future<bool> send(ApiOAuthModelAccount account, String email) {
    // TODO: implement send
    throw UnimplementedError();
  }
}
