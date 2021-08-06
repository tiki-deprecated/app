import 'package:flutter/material.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_google/api_google_service.dart';
import '../decision_card_spam/decision_card_spam_service.dart';
import '../decision_card_spam/ui/decision_card_spam_layout.dart';
import '../decision_screen/ui/decision_screen_view_card_test.dart';
import 'decision_screen_controller.dart';
import 'decision_screen_presenter.dart';
import 'model/decision_screen_model.dart';

class DecisionScreenService extends ChangeNotifier {
  late final DecisionScreenPresenter presenter;
  late final DecisionScreenController controller;
  late final DecisionScreenModel model;

  final ApiAppDataService _apiAppDataService;
  final ApiGoogleService _apiGoogleService;
  final DecisionCardSpamService _decisionCardSpamService;

  DecisionScreenService(
      {required ApiGoogleService apiGoogleService,
      required ApiAppDataService apiAppDataService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService})
      : this._apiAppDataService = apiAppDataService,
        this._apiGoogleService = apiGoogleService,
        this._decisionCardSpamService = DecisionCardSpamService(
            apiEmailSenderService: apiEmailSenderService,
            apiEmailMsgService: apiEmailMsgService,
            apiAppDataService: apiAppDataService) {
    presenter = DecisionScreenPresenter(this);
    controller = DecisionScreenController();
    model = DecisionScreenModel();
    _apiGoogleService
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

  Future<void> generateSpamCards() async {
    if (!this.model.isLinked) return;
    List<DecisionCardSpamLayout>? cards =
        await _decisionCardSpamService.getCards();
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
    ApiAppDataModel? testDone =
        await _apiAppDataService.getByKey(ApiAppDataKey.decisionCardsTestDone);
    return testDone?.value == "true";
  }

  Future<void> testDone() async {
    if (this.model.isTestDone) return;
    await _apiAppDataService.save(ApiAppDataKey.decisionCardsTestDone, "true");
    this.model.isTestDone = true;
  }
}
