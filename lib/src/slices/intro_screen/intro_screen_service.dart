/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'intro_screen_controller.dart';
import 'intro_screen_presenter.dart';
import 'model/intro_screen_model.dart';
import 'model/intro_screen_model_card.dart';

/// The Intro Screen for the first time the app is opened in the device.
class IntroScreenService extends ChangeNotifier {
  late IntroScreenPresenter presenter;
  late IntroScreenModel model;
  late IntroScreenController controller;

  IntroScreenService() {
    presenter = IntroScreenPresenter(this);
    model = IntroScreenModel();
    controller = IntroScreenController(this);
  }

  void moveToNextScreen() {
    model.currentCard++;
    notifyListeners();
  }

  void moveToPreviousScreen() {
    model.currentCard--;
    notifyListeners();
  }

  void skipToLogin() {
    model.shouldMoveToLogin = true;
    notifyListeners();
  }

  bool isLastCard() {
    return model.currentCard == (model.cards.length - 1);
  }

  bool isFirstCard() {
    return model.currentCard == 0;
  }

  IntroScreenModelCard getCurrentCard() {
    return model.cards[model.currentCard];
  }
}
