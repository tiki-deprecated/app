import 'package:app/src/slices/decision_screen/ui/decision_screen_abstract_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';
import '../../data_bkg/data_bkg_service.dart';
import '../decision_screen_service.dart';
import 'decision_screen_view_card.dart';
import 'decision_screen_view_empty.dart';
import 'decision_screen_view_link.dart';
import 'decision_screen_view_stack.dart';

class DecisionScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<DataBkgService>(context);
    return Scaffold(
      body: Center(
          child: Stack(children: [
        Container(color: ConfigColor.greyOne),
        SafeArea(
            child:
                Column(children: [HeaderBar(), Expanded(child: show(context))]))
      ])),
    );
  }

  Widget show(BuildContext context) {
    DecisionScreenService service = Provider.of<DecisionScreenService>(context);
    return FutureBuilder<bool>(
        future: service.refresh(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true)
            return LayoutBuilder(
                builder: (context, constraints) => DecisionScreenViewStack(
                    noCardsPlaceholder: DecisionScreenViewEmpty(),
                    children: _getCards(context, constraints, service)));
          else
            return DecisionScreenViewLink();
        });
  }

  List<DecisionScreenViewCard> _getCards(BuildContext context,
      BoxConstraints constraints, DecisionScreenService service) {
    List<DecisionScreenViewCard> cards = [];
    for (int i = service.model.cards.length - 1; i >= 0; i--) {
      DecisionScreenAbstractCard card = service.model.cards[i];
      cards.add(DecisionScreenViewCard(
          constraints: constraints,
          onSwipeRight: () =>
              service.controller.removeLast(context, card.callbackYes),
          onSwipeLeft: () =>
              service.controller.removeLast(context, card.callbackNo),
          child: card.content(context)));
    }
    return cards;
  }
}
