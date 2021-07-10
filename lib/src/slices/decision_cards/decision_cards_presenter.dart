import 'dart:math';

import 'package:app/src/slices/decision_cards/ui/decision_cards_layout.dart';
import 'package:app/src/slices/decision_cards/ui/decision_cards_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'decision_cards_service.dart';
import 'ui/decision_card_view.dart';

class DecisionCardsPresenter {
  final DecisionCardsService service;

  DecisionCardsPresenter(this.service);

  ChangeNotifierProvider<DecisionCardsService> render() {
    return ChangeNotifierProvider.value(
        value: service,
        child: DecisionCardsLayout(
          child: DecisionCardsStack(
              noCardsPlaceholder:
                  Container(child: Center(child: Text("no more cards"))),
              children: _generateFakeCards(5)),
        ));
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
      return DecisionCardView(
          onSwipeRight: () => print("swipe right $index"),
          onSwipeLeft: () => print("swipe left $index"),
          child: Container(
              color: colors[color],
              child: Center(child: Text("no more cards"))));
    });
  }
}
