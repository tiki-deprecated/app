/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/info_carousel/info_carousel_service.dart';
import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model.dart';
import 'package:flutter/material.dart';

class DataScreenController {
  final DataScreenService service;

  DataScreenController(this.service);

  void openGmailCards(BuildContext context) async {
    List<InfoCarouselCardModel> cards = await service.getGmailCards();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            InfoCarouselService(cards: cards).presenter.render()));
  }
}
