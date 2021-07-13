/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/wallet_screen/ui/wallet_screen_layout_body.dart';
import 'package:app/src/widgets/header_bar/header_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Column(children: [
        HeaderBar(),
        Expanded(child: WalletScreenLayoutBody())
      ]))
    ])));
  }
}
