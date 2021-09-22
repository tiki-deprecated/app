/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_email.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';

abstract class DataBkgInterfaceProvider {
  DataBkgInterfaceEmail? get emailProvider;

  Future<List<InfoCarouselCardModel>> getInfoCards(
      ApiOAuthModelAccount account);
}
