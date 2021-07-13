/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/decision_screen/decision_screen_service.dart';
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
    ApiGoogleService googleService = Provider.of<ApiGoogleService>(context);
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: Scaffold(
            backgroundColor: ConfigColor.greyOne,
            body: SafeArea(
              top: false,
              child: IndexedStack(
                  index: service.model.currentScreenIndex,
                  children: [
                    DataScreenService(googleService).presenter.render(),
                    DecisionScreenService().presenter.render(),
                    WalletScreenService().presenter.render(),
                  ]),
            ),
            bottomNavigationBar: HomeScreenViewNavBar()));
  }
}
