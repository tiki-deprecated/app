import 'package:app/src/slices/decision_card_spam/decision_card_spam_service.dart';
import 'package:app/src/slices/decision_card_spam/model/decision_card_spam_model.dart';
import 'package:app/src/slices/decision_screen/ui/decision_screen_abstract_card.dart';
import 'package:flutter/material.dart';

import 'decision_card_spam_layout_content.dart';

class DecisionCardSpamLayout implements DecisionScreenAbstractCard {
  final DecisionCardSpamModel cardSpamModel;
  final DecisionCardSpamService service;

  DecisionCardSpamLayout(this.service, this.cardSpamModel);

  @override
  Future<void> callbackNo(BuildContext context) async => this
      .service
      .controller
      .unsubscribeFromSpam(context, this.cardSpamModel.senderId);

  @override
  Future<void> callbackYes(BuildContext context) async => this
      .service
      .controller
      .keepReceiving(context, this.cardSpamModel.senderId);

  @override
  Widget content(BuildContext context) {
    var shareKey = GlobalKey();
    return Container(
        key: shareKey,
        color: Colors.white,
        child: DecisionCardSpamLayoutContent(
            shareKey, this.service, this.cardSpamModel));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionCardSpamLayout &&
          runtimeType == other.runtimeType &&
          cardSpamModel == other.cardSpamModel &&
          service == other.service;

  @override
  int get hashCode => cardSpamModel.hashCode ^ service.hashCode;
}
