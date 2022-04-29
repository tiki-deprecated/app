import 'package:decision_sdk/decision.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_account/user_account.dart';

import '../../../../../bkp/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';

class HomeScreenDecisionContainer extends StatelessWidget {
  const HomeScreenDecisionContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DecisionSdk decisionSdk = Provider.of<DecisionSdk>(context);
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ColorProvider.greyOne),
      SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(children: [
                HeaderBar(
                  userAccount: Provider.of<UserAccount>(context, listen: false),
                ),
                Expanded(child: decisionSdk.decisionWidget())
              ])))
    ])));
  }
}
