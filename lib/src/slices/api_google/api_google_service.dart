/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import '../../config/config_sentry.dart';
import '../../utils/helper_json.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_email.dart';
import '../data_bkg/data_bkg_interface_provider.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'api_google_service_email.dart';
import 'repository/api_google_repository_info.dart';

class ApiGoogleService
    implements ApiOAuthInterfaceProvider, DataBkgInterfaceProvider {
  final ApiOAuthService _apiAuthService;
  final ApiGoogleRepositoryInfo _apiGoogleRepositoryInfo;
  final ApiGoogleServiceEmail _apiGoogleServiceEmail;

  ApiGoogleService(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : this._apiAuthService = apiAuthService,
        this._apiGoogleRepositoryInfo = ApiGoogleRepositoryInfo(),
        this._apiGoogleServiceEmail = ApiGoogleServiceEmail();

  @override
  DataBkgInterfaceEmail? get email => _apiGoogleServiceEmail;

  @override
  Future<bool> isConnected(ApiOAuthModelAccount account) async {
    return (await _apiAuthService.getUserInfo(account)) != null;
  }

  @override
  Future<void> revokeToken(ApiOAuthModelAccount account) async {
    await ConfigSentry.http.post(Uri.parse(
        'https://oauth2.googleapis.com/revoke?token=' + account.accessToken!));
  }

  // TODO in the future we'll have account specific infocards
  @override
  Future<List<InfoCarouselCardModel>> getInfoCards(
      ApiOAuthModelAccount account) async {
    List<dynamic>? infoJson = await _apiGoogleRepositoryInfo.gmail();
    return HelperJson.listFromJson(
        infoJson, (s) => InfoCarouselCardModel.fromJson(s));
  }
}
