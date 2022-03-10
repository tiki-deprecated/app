/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'info_carousel_controller.dart';
import 'info_carousel_presenter.dart';
import 'model/info_carousel_model.dart';

class InfoCarouselService extends ChangeNotifier {
  late final InfoCarouselPresenter presenter;
  late final InfoCarouselModel model;
  late final InfoCarouselController controller;

  InfoCarouselService({List? cards}) {
    presenter = InfoCarouselPresenter(this);
    model = InfoCarouselModel(cards: cards);
    controller = InfoCarouselController();
  }

  void setCards(List<InfoCarouselCardModel> cards) {
    model.cards = cards;
    notifyListeners();
  }

  void addCard(InfoCarouselCardModel card) {
    model.cards ??= [];
    model.cards!.add(card);
    notifyListeners();
  }

  void removeCard(InfoCarouselCardModel card) {
    model.cards!.remove(card);
    notifyListeners();
  }
}
