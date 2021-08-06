/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data_screen/data_screen_service.dart';
import '../../decision_screen/decision_screen_service.dart';
import '../../wallet_screen/wallet_screen_service.dart';
import '../home_screen_service.dart';
import '../model/home_screen_model.dart';

class HomeScreenViewStack extends StatelessWidget {
  final DataScreenService dataScreenService;
  final DecisionScreenService decisionScreenService;
  final WalletScreenService walletScreenService;

  HomeScreenViewStack(
      {required this.dataScreenService,
      required this.decisionScreenService,
      required this.walletScreenService});

  @override
  Widget build(BuildContext context) {
    HomeScreenModel model = Provider.of<HomeScreenService>(context).model;
    return IndexedStack(index: model.currentScreenIndex, children: [
      dataScreenService.presenter.render(),
      decisionScreenService.presenter.render(),
      walletScreenService.presenter.render(),
    ]);
  }
}
