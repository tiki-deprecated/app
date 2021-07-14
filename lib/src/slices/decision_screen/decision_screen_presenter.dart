/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import 'decision_screen_service.dart';
import 'ui/decision_screen_layout.dart';

class DecisionScreenPresenter {
  final DecisionScreenService service;

  DecisionScreenPresenter(this.service);

  ChangeNotifierProvider<DecisionScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: DecisionScreenLayout());
  }
}
