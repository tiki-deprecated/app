import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:flutter/material.dart';

import 'decision_screen_controller.dart';
import 'decision_screen_presenter.dart';
import 'model/decision_screen_model.dart';

class DecisionScreenService extends ChangeNotifier {
  late final DecisionScreenPresenter presenter;
  late final DecisionScreenController controller;
  late final DecisionScreenModel model;
  final ApiGoogleService apiGoogleService;

  DecisionScreenService(this.apiGoogleService) {
    presenter = DecisionScreenPresenter(this);
    controller = DecisionScreenController();
    model = DecisionScreenModel();
    apiGoogleService
        .isConnected()
        .then((isConnected) => updateIsLinked(isConnected));
  }

  void updateIsLinked(bool isLinked) {
    this.model.isLinked = isLinked;
    notifyListeners();
  }

  generateContentCards() {
    return [
      "test-card-lemon",
      "test-card-pineapple",
      "test-card-watermelon",
    ];
  }

  void removeCard(int i) {
    this.model.cards.removeLast();
    notifyListeners();
  }
}
