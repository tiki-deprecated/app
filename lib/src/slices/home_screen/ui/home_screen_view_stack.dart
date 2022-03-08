/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import '../../data_screen/data_screen_service.dart';
import '../../decision_screen/decision_screen_service.dart';
import '../home_screen_service.dart';
import '../model/home_screen_model.dart';
import 'home_screen_money_container.dart';
import 'home_screen_view_nav_bar.dart';
import 'home_screen_view_overlay.dart';

class HomeScreenViewStack extends StatelessWidget {
  final DataScreenService dataScreenService;
  final DecisionScreenService decisionScreenService;

  HomeScreenViewStack(
      {required this.dataScreenService, required this.decisionScreenService});

  @override
  Widget build(BuildContext context) {
    HomeScreenModel model = Provider.of<HomeScreenService>(context).model;
    return Stack(children: [
      Scaffold(
          backgroundColor: ConfigColor.greyOne,
          bottomNavigationBar: HomeScreenViewNavBar(),
          body: SafeArea(
              top: false,
              child: IndexedStack(index: model.currentScreenIndex, children: [
                dataScreenService.presenter.render(),
                decisionScreenService.presenter.render(),
                HomeScreenMoneyContainer(),
              ]))),
      if (model.showOverlay == true && model.currentScreenIndex == 1)
        HomeScreenViewOverlay()
    ]);
  }
}
