/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_email.dart';
import '../data_bkg/data_bkg_interface_provider.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'api_microsoft_service_email.dart';

class ApiMicrosoftService
    implements ApiOAuthInterfaceProvider, DataBkgInterfaceProvider {
  final ApiMicrosoftServiceEmail _apiMicrosoftServiceEmail;

  ApiMicrosoftService()
      : this._apiMicrosoftServiceEmail = ApiMicrosoftServiceEmail();

  @override
  // TODO: implement email
  DataBkgInterfaceEmail? get email => _apiMicrosoftServiceEmail;

  @override
  Future<List<InfoCarouselCardModel>> getInfoCards(
      ApiOAuthModelAccount account) {
    // TODO: implement getInfoCards
    throw UnimplementedError();
  }

  @override
  Future<bool> isConnected(ApiOAuthModelAccount account) {
    // TODO: implement isConnected
    throw UnimplementedError();
  }

  @override
  Future<void> revokeToken(ApiOAuthModelAccount account) {
    // TODO: implement revokeToken
    throw UnimplementedError();
  }
}
