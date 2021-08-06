/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import '../../api_app_data/api_app_data_service.dart';
import '../../api_email_msg/api_email_msg_service.dart';
import '../../api_email_sender/api_email_sender_service.dart';
import '../../api_google/api_google_service.dart';
import '../../data_bkg/data_bkg_service.dart';
import '../../data_screen/data_screen_service.dart';
import '../../decision_screen/decision_screen_service.dart';
import '../../wallet_screen/wallet_screen_service.dart';
import '../home_screen_service.dart';
import '../model/home_screen_model.dart';
import 'home_screen_view_nav_bar.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeScreenModel model = Provider.of<HomeScreenService>(context).model;
    ApiGoogleService googleService =
        Provider.of<ApiGoogleService>(context, listen: false);
    DataBkgService dataBkgService =
        Provider.of<DataBkgService>(context, listen: false);
    ApiAppDataService appDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    ApiEmailMsgService apiEmailMsgService =
        Provider.of<ApiEmailMsgService>(context, listen: false);
    ApiEmailSenderService apiEmailSenderService =
        Provider.of<ApiEmailSenderService>(context, listen: false);
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: Scaffold(
            backgroundColor: ConfigColor.greyOne,
            body: SafeArea(
              top: false,
              child: IndexedStack(index: model.currentScreenIndex, children: [
                DataScreenService(googleService, dataBkgService)
                    .presenter
                    .render(),
                DecisionScreenService(
                        apiEmailSenderService: apiEmailSenderService,
                        apiEmailMsgService: apiEmailMsgService,
                        apiGoogleService: googleService,
                        apiAppDataService: appDataService)
                    .presenter
                    .render(),
                WalletScreenService().presenter.render(),
              ]),
            ),
            bottomNavigationBar: HomeScreenViewNavBar()));
  }
}
