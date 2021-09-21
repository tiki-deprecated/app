/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:http/http.dart';

import '../../config/config_sentry.dart';
import '../../utils/api/helper_api_utils.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_sv_provider_interface.dart';
import 'api_google_service_email.dart';

class ApiGoogleService implements ApiAuthServiceProviderInterface {
  final ApiAuthService _apiAuthService;
  final ApiGoogleServiceEmail _apiGoogleServiceEmail;

  ApiGoogleService(
      {required ApiAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : this._apiAuthService = apiAuthService,
        this._apiGoogleServiceEmail =
            ApiGoogleServiceEmail(apiAppDataService: apiAppDataService);

  @override
  Future<void> logOut(ApiAuthServiceAccountModel account) async {
    Response rsp = await ConfigSentry.http.post(Uri.parse(
        'https://oauth2.googleapis.com/revoke?token=' + account.accessToken!));
    if (HelperApiUtils.is2xx(rsp.statusCode)) {
      await _apiAuthService.signOut(account);
    }
  }

  get emailProvider => _apiGoogleServiceEmail;

  @override
  Future<void> logIn(ApiAuthServiceAccountModel _account) async {
    // TODO any specific routine?
  }

  @override
  Future<bool> isConnected(ApiAuthServiceAccountModel account) async {
    return (await _apiAuthService.getUserInfo(account)) != null;
  }
}
