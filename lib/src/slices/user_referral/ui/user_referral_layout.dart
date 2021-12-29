/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'user_referral_view_code.dart';
import 'user_referral_view_count.dart';
import 'user_referral_view_text.dart';

class UserReferralLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      UserReferralViewText(),
      Container(
          margin: EdgeInsets.only(top: 1.5.h, left: 8.w, right: 8.w),
          child: UserReferralViewCode()),
      Container(
          margin: EdgeInsets.only(top: 1.h), child: UserReferralViewCount())
    ]);
  }
}
