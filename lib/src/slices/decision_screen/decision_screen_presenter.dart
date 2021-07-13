/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'decision_screen_service.dart';
import 'ui/decision_screen_layout.dart';
import 'ui/decision_screen_view_card.dart';

class DecisionScreenPresenter {
  final DecisionScreenService service;

  DecisionScreenPresenter(this.service);

  ChangeNotifierProvider<DecisionScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: DecisionScreenLayout());
  }

  List<Widget> _generateFakeCards(int i) {
    List colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.blue
    ];
    Random random = new Random();
    return List.generate(i, (index) {
      int color = random.nextInt(5);
      return DecisionScreenViewCard(
          onSwipeRight: () => print("swipe right $index"),
          onSwipeLeft: () => print("swipe left $index"),
          child: Container(
              color: colors[color],
              child: Center(child: Text("no more cards"))));
    });
  }
}
