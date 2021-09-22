/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:http/http.dart';

import '../../config/config_sentry.dart';
import '../../utils/api/helper_api_utils.dart';
import '../../utils/helper_json.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_provider.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'api_google_service_email.dart';
import 'repository/api_google_repository_info.dart';

class ApiGoogleService
    implements ApiOAuthInterfaceProvider, DataBkgInterfaceProvider {
  final ApiOAuthService _apiAuthService;
  final ApiGoogleServiceEmail _apiGoogleServiceEmail;

  ApiGoogleService(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : this._apiAuthService = apiAuthService,
        this._apiGoogleServiceEmail =
            ApiGoogleServiceEmail(apiAppDataService: apiAppDataService);

  @override
  Future<void> logOut(ApiOAuthModelAccount account) async {
    Response rsp = await ConfigSentry.http.post(Uri.parse(
        'https://oauth2.googleapis.com/revoke?token=' + account.accessToken!));
    if (HelperApiUtils.is2xx(rsp.statusCode)) {
      await _apiAuthService.signOut(account);
    }
  }

  get emailProvider => _apiGoogleServiceEmail;

  @override
  Future<void> logIn(ApiOAuthModelAccount _account) async {
    // TODO any specific routine?
  }

  @override
  Future<bool> isConnected(ApiOAuthModelAccount account) async {
    return (await _apiAuthService.getUserInfo(account)) != null;
  }

  // TODO in the future we'll have account specific infocards
  @override
  Future<List<InfoCarouselCardModel>> getInfoCards(
      ApiOAuthModelAccount account) async {
    List<dynamic>? infoJson = await ApiGoogleRepositoryInfo().gmail();
    return HelperJson.listFromJson(
        infoJson, (s) => InfoCarouselCardModel.fromJson(s));
  }
}
