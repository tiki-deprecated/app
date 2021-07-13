import 'package:flutter/material.dart';

import 'decision_cards_controller.dart';
import 'decision_cards_presenter.dart';
import 'model/decision_card_model.dart';

class DecisionCardsService extends ChangeNotifier {
  late DecisionCardsPresenter presenter;
  late DecisionCardsController controller;
  late DecisionCardsModel model;

  DecisionCardsService() {
    presenter = DecisionCardsPresenter(this);
    controller = DecisionCardsController();
    model = DecisionCardsModel();
  }
}
