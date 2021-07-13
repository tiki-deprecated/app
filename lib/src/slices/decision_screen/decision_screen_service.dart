import 'package:flutter/material.dart';

import 'decision_screen_controller.dart';
import 'decision_screen_presenter.dart';
import 'model/decision_screen_model.dart';

class DecisionScreenService extends ChangeNotifier {
  late DecisionScreenPresenter presenter;
  late DecisionScreenController controller;
  late DecisionScreenModel model;

  DecisionScreenService() {
    presenter = DecisionScreenPresenter(this);
    controller = DecisionScreenController();
    model = DecisionScreenModel();
  }
}
