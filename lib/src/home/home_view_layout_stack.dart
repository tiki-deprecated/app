/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'home_model.dart';
import 'home_service.dart';
import 'home_view_layout_data.dart';
import 'home_view_layout_decision.dart';
import 'home_view_layout_money.dart';
import 'home_view_widget_nav_bar.dart';
import 'home_view_widget_overlay.dart';

class HomeViewLayoutStack extends StatelessWidget {
  const HomeViewLayoutStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeModel model = Provider.of<HomeService>(context).model;
    return Stack(children: [
      Scaffold(
          backgroundColor: ColorProvider.greyOne,
          bottomNavigationBar: const HomeViewWidgetNavBar(),
          body: SafeArea(
              top: false,
              child: IndexedStack(
                  index: model.currentScreenIndex,
                  children: const [
                    HomeViewLayoutData(),
                    HomeViewLayoutDecision(),
                    HomeViewLayoutMoney(),
                  ]))),
      if (model.showOverlay == true && model.currentScreenIndex == 1)
        const HomeViewWidgetOverlay()
    ]);
  }
}
