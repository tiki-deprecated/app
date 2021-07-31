import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:app/src/slices/decision_card_spam/decision_card_spam_service.dart';
import 'package:app/src/slices/decision_screen/ui/decision_screen_view_card_test.dart';
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

  void updateIsLinked(bool isLinked) async {
    this.model.isLinked = isLinked;
    this.model.isTestDone = await this.isTestDone();
    notifyListeners();
  }

  void removeCard() {
    this.model.cards.removeLast();
    notifyListeners();
  }

  Future<void> generateSpamCards(BuildContext context) async {
    if (!this.model.isLinked) return;
    var decisionCardSpamService = DecisionCardSpamService();
    var cards = await decisionCardSpamService.getCards(context);
    if (cards != null && cards.isNotEmpty) {
      this.model.cards = [...cards];
      notifyListeners();
    }
  }

  void generateTestCards() {
    this.model.cards = List<DecisionScreenViewCardTest>.generate(
        3, (index) => DecisionScreenViewCardTest(index)).reversed.toList();
  }

  Future<bool> isTestDone() async {
    var testDone =
        await ApiAppDataService().getByKey("decision cards test done");
    return testDone?.value == "true";
  }

  Future<void> testDone() async {
    if (this.model.isTestDone) return;
    await ApiAppDataService().save("decision cards test done", "true");
    this.model.isTestDone = true;
  }
}
