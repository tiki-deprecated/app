/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:app/src/slices/api_signup/api_signup_service.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:app/src/slices/user_referral/user_referral_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserReferralController {
  static const String _linkUrl = "https://mytiki.com/";

  final UserReferralService service;

  UserReferralController(this.service);

  copyLink(BuildContext context) async {
    LoginFlowService loginFlowService =
        Provider.of<LoginFlowService>(context, listen: false);
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    await Clipboard.setData(new ClipboardData(
        text: _linkUrl + service.getCode(apiAppDataService, loginFlowService)));
  }

  Future<void> updateReferCount(BuildContext context) async {
    ApiSignupService apiSignupService =
        Provider.of<ApiSignupService>(context, listen: false);
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    await service.updateReferCount(apiAppDataService, apiSignupService);
  }
}
