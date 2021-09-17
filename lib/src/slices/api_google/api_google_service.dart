/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../data_bkg/data_bkg_sv_provider_interface.dart';
import 'model/api_google_model.dart';

class ApiGoogleService implements DataBkgServiceProviderInterface {
  final ApiGoogleModel model = ApiGoogleModel();
  final ApiAuthService _apiAuthService;

  ApiGoogleService(this._apiAuthService);

  @override
  Future<void> logOut(ApiAuthServiceAccountModel account) async {
    // TODO remove all data
    await _apiAuthService.signOut(account);
  }

  @override
  Future<void> logIn(ApiAuthServiceAccountModel _account) async {
    // TODO any specific routine?
  }

  @override
  Future<bool> isConnected(ApiAuthServiceAccountModel account) async {
    return (await _apiAuthService.getUserInfo(account)) != null;
  }
}
