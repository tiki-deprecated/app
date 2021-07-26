/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_unsubscribe_spam/api_unsubscribe_spam_service.dart';
import 'package:app/src/slices/decision_card_spam/model/decision_card_spam_model.dart';
import 'package:app/src/slices/decision_card_spam/ui/decision_card_spam_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'decision_card_spam_controller.dart';

class DecisionCardSpamService extends ChangeNotifier {
  late final DecisionCardSpamController controller;

  DecisionCardSpamService() {
    controller = DecisionCardSpamController(this);
  }

  Future<List<DecisionCardSpamLayout>> getCards(BuildContext context) async {
    var apiUnsubscribeSpam = Provider.of<ApiUnsubscribeSpamService>(context);
    List<DecisionCardSpamModel> sendersDataForCards =
        await apiUnsubscribeSpam.getDataForCards();
    return sendersDataForCards
        .map((spamModel) => DecisionCardSpamLayout(this, spamModel))
        .toList();
  }

  unsubscribeFromSpam(BuildContext context, int senderId) {
    var apiUnsubscribeSpam = Provider.of<ApiUnsubscribeSpamService>(context);
    apiUnsubscribeSpam.unsubscribe(senderId);
  }

  keepReceiving(BuildContext context, int senderId) {
    var apiUnsubscribeSpam = Provider.of<ApiUnsubscribeSpamService>(context);
    apiUnsubscribeSpam.keepReceiving(senderId);
  }
}
