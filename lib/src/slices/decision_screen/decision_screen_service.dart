import 'package:flutter/material.dart';

import 'decision_screen_controller.dart';
import 'decision_screen_presenter.dart';
import 'model/decision_screen_model.dart';

class DecisionScreenService extends ChangeNotifier {
  late final DecisionScreenPresenter presenter;
  late final DecisionScreenController controller;
  late final DecisionScreenModel model;
 // final ApiGoogleService apiGoogleService;

  DecisionScreenService() {
    presenter = DecisionScreenPresenter(this);
    controller = DecisionScreenController();
    model = DecisionScreenModel();
    this.model.isLinked = true;
    // apiGoogleService
    //     .isConnected()
    //     .then((isConnected) => updateIsLinked(isConnected));
  }

  void updateIsLinked(bool isLinked) {
    this.model.isLinked = true; //isLinked;
    notifyListeners();
  }
}
