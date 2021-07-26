import 'package:app/src/slices/decision_card_spam/decision_card_spam_service.dart';
import 'package:app/src/slices/decision_card_spam/model/decision_card_spam_model.dart';
import 'package:app/src/slices/decision_screen/model/decision_screen_model.dart';
import 'package:flutter/material.dart';

class DecisionCardSpamLayout implements AbstractDecisionCardView {
  final DecisionCardSpamModel cardSpamModel;
  final DecisionCardSpamService service;

  DecisionCardSpamLayout(this.service, this.cardSpamModel);

  @override
  Future<void> callbackNo(BuildContext context) async {
    this
        .service
        .controller
        .unsubscribeFromSpam(context, this.cardSpamModel.senderId);
  }

  @override
  Future<void> callbackYes(BuildContext context) async {
    this.service.controller.keepReceiving(context, this.cardSpamModel.senderId);
  }

  @override
  Widget content(BuildContext context) {
    return Container();
  }
}
