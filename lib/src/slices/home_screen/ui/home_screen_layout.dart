/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/decision_screen/decision_screen_service.dart';
import 'package:app/src/slices/decision_screen/ui/decision_screen_view_overlay.dart';
import 'package:app/src/slices/home_screen/ui/home_screen_view_stack.dart';
import 'package:app/src/slices/wallet_screen/wallet_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config_color.dart';
import '../../api_app_data/api_app_data_service.dart';
import '../../api_email_msg/api_email_msg_service.dart';
import '../../api_email_sender/api_email_sender_service.dart';
import '../../api_google/api_google_service.dart';
import '../../data_bkg/data_bkg_service.dart';
import 'home_screen_view_nav_bar.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    bool showSwipeOverlay = false; // TODO: change variable in HomeScreenService
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: Stack(children: [
          Scaffold(
              backgroundColor: ConfigColor.greyOne,
              body: SafeArea(
                  top: false,
                  child: HomeScreenViewStack(
                    decisionScreenService: DecisionScreenService(
                        apiGoogleService: googleService,
                        apiEmailMsgService: apiEmailMsgService,
                        apiEmailSenderService: apiEmailSenderService,
                        apiAppDataService: appDataService),
                    dataScreenService:
                        DataScreenService(googleService, dataBkgService),
                    walletScreenService: WalletScreenService(),
                  )),
              bottomNavigationBar: HomeScreenViewNavBar()),
          showSwipeOverlay ? DecisionScreenViewOverlay() : Container(),
        ]));
  }
}
