/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/user_referral/ui/user_referral_view_code.dart';
import 'package:app/src/slices/user_referral/ui/user_referral_view_count.dart';
import 'package:app/src/slices/user_referral/ui/user_referral_view_text.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

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
