/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/decision_card_spam/decision_card_spam_service.dart';
import 'package:flutter/material.dart';

class DecisionCardSpamController {
  final DecisionCardSpamService service;

  DecisionCardSpamController(this.service);

  Future<void> unsubscribeFromSpam(BuildContext context, int senderId) async =>
      this.service.unsubscribeFromSpam(context, senderId);

  Future<void> keepReceiving(BuildContext context, int senderId) async =>
      this.service.keepReceiving(context, senderId);

  shareCard(BuildContext context, param1, param2) {}
}
