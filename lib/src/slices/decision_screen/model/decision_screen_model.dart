/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/decision_screen/ui/decision_screen_abstract_card.dart';

class DecisionScreenModel {
  List<DecisionScreenAbstractCard> cards = [];
  bool isLinked = false;
  bool testCardsAdded = false;
  bool isPending = false;
}
