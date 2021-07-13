import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/decision_screen/ui/decision_screen_view_stack.dart';
import 'package:app/src/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../decision_screen_service.dart';
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
      return DecisionScreenViewStack(
          noCardsPlaceholder: DecisionScreenViewEmpty(), children: []);
    else
      return DecisionScreenViewLink();
  }
}
