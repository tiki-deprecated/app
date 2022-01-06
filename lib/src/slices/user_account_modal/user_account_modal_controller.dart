/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../api_signup/api_signup_service.dart';
import '../logout_modal/logout_modal_service.dart';
import '../support_modal/support_modal_service.dart';
import '../user_referral/user_referral_service.dart';
import 'user_account_modal_service.dart';

class UserAccountModalController {
  static const String _shareBody =
      "Your data. Your decisions. Take the take power back from corporations. Together, we triumph. Join us! ";
  static const String _shareLink = "https://mytiki.com/";
  static const String _shareSubject = "Have you seen this???";

  final UserAccountModalService service;

  UserAccountModalController(this.service);

  void onLogout(BuildContext context) {
    Navigator.of(context).pop();
    LogoutModalService().presenter.showModal(context);
  }

  Future<void> onShare(UserReferralService userReferralService) async {
    await userReferralService.getCode();
    if (userReferralService.model.code.isNotEmpty) {
      Share.share(_shareBody + _shareLink + userReferralService.model.code,
          subject: _shareSubject);
    }
  }

  void updateUserCount(BuildContext context) {
    ApiSignupService apiSignupService =
        Provider.of<ApiSignupService>(context, listen: false);
    service.updateSignups(apiSignupService);
  }

  void goToSupport(BuildContext context) {
    Navigator.of(context).pop();
    SupportModalService().presenter.showModal(context);
  }
}
