/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/decision_screen/decision_screen_service.dart';
import 'package:app/src/slices/home_screen/home_screen_service.dart';
import 'package:app/src/slices/home_screen/model/home_screen_model.dart';
import 'package:app/src/slices/home_screen/ui/home_screen_view_nav_bar.dart';
import 'package:app/src/slices/wallet_screen/wallet_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeScreenModel model = Provider.of<HomeScreenService>(context).model;
    ApiGoogleService googleService =
        Provider.of<ApiGoogleService>(context, listen: false);
    ApiAppDataService appDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: Scaffold(
            backgroundColor: ConfigColor.greyOne,
            body: SafeArea(
              top: false,
              child: IndexedStack(index: model.currentScreenIndex, children: [
                DataScreenService(googleService).presenter.render(),
                DecisionScreenService(googleService, appDataService)
                    .presenter
                    .render(),
                WalletScreenService().presenter.render(),
              ]),
            ),
            bottomNavigationBar: HomeScreenViewNavBar()));
  }
}
