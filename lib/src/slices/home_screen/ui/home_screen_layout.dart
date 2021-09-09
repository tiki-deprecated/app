/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api_app_data/api_app_data_service.dart';
import '../../api_auth_service/api_auth_service.dart';
import '../../api_company/api_company_service.dart';
import '../../api_email_msg/api_email_msg_service.dart';
import '../../api_email_sender/api_email_sender_service.dart';
import '../../api_google/api_google_service.dart';
import '../../data_bkg/data_bkg_service.dart';
import '../../data_screen/data_screen_service.dart';
import '../../decision_screen/decision_screen_service.dart';
import '../../home_screen/ui/home_screen_view_stack.dart';
import '../../wallet_screen/wallet_screen_service.dart';

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
    ApiCompanyService apiCompanyService =
        Provider.of<ApiCompanyService>(context, listen: false);
    ApiAuthService apiAuthService =
        Provider.of<ApiAuthService>(context, listen: false);
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: HomeScreenViewStack(
          decisionScreenService: DecisionScreenService(
              apiGoogleService: googleService,
              apiEmailMsgService: apiEmailMsgService,
              apiEmailSenderService: apiEmailSenderService,
              apiCompanyService: apiCompanyService,
              apiAppDataService: appDataService,
              dataBkgService: dataBkgService,
              apiAuthService: apiAuthService),
          dataScreenService: DataScreenService(dataBkgService),
          walletScreenService: WalletScreenService(),
        ));
  }
}
