/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/user_referral/user_referral_service.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class WalletScreenViewReferral extends StatelessWidget {
  static const String _text = "YOUR REFERRALS";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ConfigColor.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2.w,
            offset: Offset(0.75.w, 0.75.w), // Shadow position
          ),
        ],
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _text,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: ConfigColor.tikiBlue),
              ),
              Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: UserReferralService().presenter.render())
            ],
          )),
    );
  }
}
