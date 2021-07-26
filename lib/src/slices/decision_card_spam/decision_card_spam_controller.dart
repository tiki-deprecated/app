/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/decision_card_spam/decision_card_spam_service.dart';
import 'package:flutter/material.dart';

class DecisionCardSpamController {
  final DecisionCardSpamService service;

  DecisionCardSpamController(this.service);

  unsubscribeFromSpam(BuildContext context, int senderId) {
    this.service.unsubscribeFromSpam(context, senderId);
  }

  keepReceiving(BuildContext context, int senderId) {
    this.service.keepReceiving(context, senderId);
  }
}
