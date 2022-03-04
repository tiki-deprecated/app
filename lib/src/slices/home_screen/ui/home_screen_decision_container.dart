import 'package:decision_sdk/decision.dart';
import 'package:flutter/material.dart';
import 'package:money/money.dart';

import '../../../config/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';

class HomeScreenDecisionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Column(children: [
                HeaderBar(),
                Expanded(child: DecisionSdk(isConnected: true).home())
              ])))
    ])));
  }
}
