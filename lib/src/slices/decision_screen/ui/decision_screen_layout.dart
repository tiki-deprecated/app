import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/decision_screen/ui/decision_screen_view_stack.dart';
import 'package:app/src/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../decision_screen_service.dart';
import 'decision_screen_view_card.dart';
import 'decision_screen_view_empty.dart';
import 'decision_screen_view_link.dart';

class DecisionScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child:
              Column(children: [HeaderBar(), Expanded(child: show(context))]))
    ])));
  }

  Widget show(BuildContext context) {
    var model = Provider.of<DecisionScreenService>(context).model;
    if (model.isLinked == true)
      return LayoutBuilder(
          builder: (context, constraints) => DecisionScreenViewStack(
              noCardsPlaceholder: DecisionScreenViewEmpty(),
              children: _getCards(context, constraints)));
    else
      return DecisionScreenViewLink();
  }

  List<DecisionScreenViewCard> _getCards(
      BuildContext context, BoxConstraints constraints) {
    var service = Provider.of<DecisionScreenService>(context, listen: false);
    List<DecisionScreenViewCard> cards = [];
    if (service.model.cards.isEmpty) {
      if (service.model.isTestDone) {
        service.generateSpamCards();
      } else {
        service.generateTestCards();
      }
    }
    service.model.cards.forEach((card) {
      cards.add(DecisionScreenViewCard(
          constraints: constraints,
          onSwipeRight: () =>
              service.controller.removeLast(context, card.callbackYes),
          onSwipeLeft: () =>
              service.controller.removeLast(context, card.callbackNo),
          child: card.content(context)));
    });
    return cards;
  }
}
