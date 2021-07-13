/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/home_screen/home_screen_service.dart';
import 'package:app/src/slices/home_screen/ui/home_screen_view_nav_bar.dart';
import 'package:app/src/slices/wallet_screen/wallet_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeScreenService service = Provider.of<HomeScreenService>(context);
    return Scaffold(
        backgroundColor: ConfigColor.greyOne,
        body: SafeArea(
          top: false,
          child: IndexedStack(
              index: service.model.currentScreenIndex,
              children: [
                DataScreenService().presenter.render(),
                WalletScreenService().presenter.render()
              ]),
        ),
        bottomNavigationBar: HomeScreenViewNavBar());
  }
}
