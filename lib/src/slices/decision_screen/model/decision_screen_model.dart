/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

class DecisionScreenModel {
  bool isLinked = false;
  List<AbstractDecisionCardView> cards = [];
}

abstract class AbstractDecisionCardView {
  Future<void> callbackNo(BuildContext context);

  Future<void> callbackYes(BuildContext context);

  Widget content(BuildContext context);
}
