import 'package:flutter/material.dart';
import 'package:money/money.dart';
import 'package:provider/provider.dart';
import 'package:user_account/user_account.dart';

import '../../../config/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';

class HomeScreenMoneyContainer extends StatelessWidget {

  const HomeScreenMoneyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(children: [
                HeaderBar(userAccount: Provider.of<UserAccount>(context, listen:false),),
                Expanded(child: Money().home(example: true))
              ])))
    ])));
  }
}
