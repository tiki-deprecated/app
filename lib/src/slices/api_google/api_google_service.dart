/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../utils/helper_json.dart';
import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../data_bkg/data_bkg_service_provider.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'model/api_google_model.dart';
import 'repository/api_google_repository_info.dart';

class ApiGoogleService implements DataBkgServiceProviderInterface {
  final ApiGoogleModel model = ApiGoogleModel();
  final ApiAuthService _apiAuthService;
  ApiAuthServiceAccountModel _account;

  ApiGoogleService(this._account, this._apiAuthService);

  @override
  Future<void> logOut() async {
    // TODO remove all data
    await _apiAuthService.signOut(_account);
  }

  @override
  Future<void> logIn() async {
    // TODO any specific routine?
  }

  @override
  Future<bool> isConnected() async {
    return (await _apiAuthService.getUserInfo(_account)) != null;
  }

  static Future<List<InfoCarouselCardModel>> gmailInfoCards() async {
    List<dynamic>? infoJson = await ApiGoogleRepositoryInfo().gmail();
    return HelperJson.listFromJson(
        infoJson, (s) => InfoCarouselCardModel.fromJson(s));
  }

  @override
  ApiAuthServiceAccountModel get account => _account;

  @override
  String? get displayName => _account.displayName;
}
