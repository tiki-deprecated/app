/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';

abstract class DataFetchInterfaceProvider {
  DataFetchInterfaceEmail? get email;

  Future<List<InfoCarouselCardModel>> getInfoCards(
      ApiOAuthModelAccount account);
}
