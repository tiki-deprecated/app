/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:app/src/slices/api_signup/api_signup_service.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:app/src/slices/user_account_modal/user_account_modal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class UserAccountModalController {
  static const String _shareBody =
      "Your data. Your decisions. Take the take power back from corporations. Together, we triumph. Join us! ";
  static const String _shareLink = "https://mytiki.com/";
  static const String _shareSubject = "Have you seen this???";

  final UserAccountModalService service;

  UserAccountModalController(this.service);

  void onLogout(BuildContext context) {
    Provider.of<LoginFlowService>(context, listen: false).setLoggedOut();
    Provider.of<ApiAppDataService>(context, listen: false).deleteOnLogout();
  }

  void onShare(BuildContext context) {
    LoginFlowService loginFlowService =
        Provider.of<LoginFlowService>(context, listen: false);
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    String code =
        service.referralService.getCode(apiAppDataService, loginFlowService);
    Share.share(_shareBody + _shareLink + code, subject: _shareSubject);
  }

  void updateUserCount(BuildContext context) {
    ApiSignupService apiSignupService =
        Provider.of<ApiSignupService>(context, listen: false);
    service.updateSignups(apiSignupService);
  }
}
