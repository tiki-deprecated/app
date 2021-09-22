/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

// ignore_for_file: unused_import

import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_provider.dart';

class ApiMicrosoftService
    implements ApiOAuthInterfaceProvider, DataBkgInterfaceProvider {
  @override
  isConnected(ApiOAuthModelAccount account) {
    // TODO: implement isConnected
    throw UnimplementedError();
  }

  @override
  logIn(ApiOAuthModelAccount account) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  logOut(ApiOAuthModelAccount account) {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  // TODO: implement emailProvider
  get emailProvider => throw UnimplementedError();

  @override
  getInfoCards(ApiOAuthModelAccount account) {
    // TODO: implement getInfoCards
    throw UnimplementedError();
  }
}
