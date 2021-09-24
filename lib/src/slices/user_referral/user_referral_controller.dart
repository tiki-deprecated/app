/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'user_referral_service.dart';

class UserReferralController {
  static const String _linkUrl = "https://mytiki.com/";

  final UserReferralService service;

  UserReferralController(this.service);

  copyLink(BuildContext context) async {
    await Clipboard.setData(
        new ClipboardData(text: _linkUrl + service.model.code));
  }

  Future<void> updateReferCount(BuildContext context) async {
    await service.updateReferCount();
  }
}
