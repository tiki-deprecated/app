/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zendesk_flutter/src/zendesk_flutter_style.dart';
import 'package:zendesk_flutter/zendesk_flutter.dart';

import '../logout_modal/logout_modal_service.dart';
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
    LogoutModalService(service.login).presenter.showModal(context);
  }

  Future<void> onShare(UserReferralService userReferralService) async {
    await userReferralService.getCode();
    if (userReferralService.model.code.isNotEmpty) {
      Share.share(_shareBody + _shareLink + userReferralService.model.code,
          subject: _shareSubject);
    }
  }

  void updateUserCount() {
    service.updateSignups();
  }

  void goToSupport(BuildContext context) {
    Navigator.of(context).pop();
    ZendeskFlutterStyle style = ZendeskFlutterStyle(
        cardBackground: Colors.white,
        modalNavColor: const Color(0xFFF0F0F0),
        textColor: const Color(0xFF8D8D8D),
        accentColor: const Color(0xFF1C0000),
        fontFamily: 'NunitoSans',
        titleFont: 'Koara',
        subtitleFont: 'NunitoSans');
    ZendeskFlutter(style: style).show(context);
  }

  void showQrCode(BuildContext context) {
    this.service.showQrCode();
  }
}
