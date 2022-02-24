/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:http/http.dart';
import 'package:httpp/httpp.dart';

import '../../config/config_sentry.dart';
import '../../utils/json/json_utils.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import '../data_fetch/data_fetch_interface_provider.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'api_microsoft_service_email.dart';
import 'repository/api_microsoft_repository_info.dart';

class ApiMicrosoftService
    implements ApiOAuthInterfaceProvider, DataFetchInterfaceProvider {
  final ApiOAuthService _apiAuthService;
  final ApiMicrosoftRepositoryInfo _apiMicrosoftRepositoryInfo;
  final ApiMicrosoftServiceEmail _apiMicrosoftServiceEmail;

  ApiMicrosoftService(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required Httpp httpp})
      : this._apiAuthService = apiAuthService,
        this._apiMicrosoftRepositoryInfo = ApiMicrosoftRepositoryInfo(),
        this._apiMicrosoftServiceEmail = ApiMicrosoftServiceEmail(httpp);

  @override
  DataFetchInterfaceEmail? get email => _apiMicrosoftServiceEmail;

  @override
  Future<bool> isConnected(ApiOAuthModelAccount account) async =>
      (await _apiAuthService.getUserInfo(account)) != null;

  Future<Response> revokeToken(ApiOAuthModelAccount account) async =>
      await ConfigSentry.http.post(Uri.parse(
          'https://oauth2.googleapis.com/v1.0/me/revokeSignInSessions'));

  @override
  Future<List<InfoCarouselCardModel>?> getInfoCards(
          ApiOAuthModelAccount account) async =>
      JsonUtils.listFromJson<InfoCarouselCardModel>(
          await _apiMicrosoftRepositoryInfo.outlook(),
          (s) => InfoCarouselCardModel.fromJson(s));
}
