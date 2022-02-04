/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import '../info_carousel/info_carousel_service.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'data_screen_service.dart';

class DataScreenController {
  final DataScreenService service;

  DataScreenController(this.service);

  Future<void> openGmailCards(BuildContext context, int accountId) async {
    List<InfoCarouselCardModel>? cards = await service.getInfoCards(accountId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            InfoCarouselService(cards: cards).presenter.render()));
  }

  linkAccount(String provider) async {
    service.linkAccount(provider);
  }

  removeAccount() {
    service.removeAccount();
  }
}
