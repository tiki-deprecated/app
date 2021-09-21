/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_sentry.dart';
import 'package:app/src/utils/api/helper_api_utils.dart';
import 'package:http/http.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_sv_provider_interface.dart';
import 'model/api_google_model.dart';

class ApiGoogleService implements ApiAuthServiceProviderInterface {
  final ApiGoogleModel model = ApiGoogleModel();
  final ApiAuthService _apiAuthService;

  ApiGoogleService(this._apiAuthService);

  @override
  Future<void> logOut(ApiAuthServiceAccountModel account) async {
    Response rsp = await ConfigSentry.http.post(Uri.parse(
        'https://oauth2.googleapis.com/revoke?token=' + account.accessToken!));
    if (HelperApiUtils.is2xx(rsp.statusCode)) {
      await _apiAuthService.signOut(account);
    }
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
