import 'package:app/src/config/config_color.dart';
import 'package:app/src/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:money/money.dart';

class HomeScreenMoneyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Column(children: [
        HeaderBar(),
        Expanded(child: Money().home(example: true))
      ]))
    ])));
  }
}
