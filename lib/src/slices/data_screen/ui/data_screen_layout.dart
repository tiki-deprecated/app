/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_account/user_account.dart';

import '../../../config/config_color.dart';
import '../../../widgets/header_bar/header_bar.dart';
import 'data_screen_layout_body.dart';

class DataScreenLayout extends StatelessWidget {

  const DataScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      Container(color: ConfigColor.greyOne),
      SafeArea(
          child: Column(
              children: [
          HeaderBar(userAccount: Provider.of<UserAccount>(context, listen:false),), const Expanded(child: DataScreenLayoutBody())]))
    ])));
  }
}
