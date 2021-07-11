/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/user_account_modal/user_account_modal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class UserAccountModalController {
  static const String _shareBody =
      "Your data. Your decisions. Take the take power back from corporations. Together, we triumph. Join us! ";
  static const String _shareLink = "https://mytiki.com/";
  static const String _shareSubject = "Have you seen this???";

  final UserAccountModalService service;

  UserAccountModalController(this.service);

  void onLogout() {
    print("implement logout");
  }

  void onShare(BuildContext context) {
    String code = service.referralService.getCode(context);
    Share.share(_shareBody + _shareLink + code, subject: _shareSubject);
  }
}
