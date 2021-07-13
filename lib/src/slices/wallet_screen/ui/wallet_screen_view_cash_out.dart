/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import 'wallet_screen_view_cash_out_banner.dart';
import 'wallet_screen_view_cash_out_icon.dart';
import 'wallet_screen_view_cash_out_text.dart';

class WalletScreenViewCashOut extends StatelessWidget {
  static const num _borderRadius = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ConfigColor.white,
          borderRadius: BorderRadius.circular(_borderRadius.w),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 2.w,
              offset: Offset(0.75.w, 0.75.w), // Shadow position
            ),
          ],
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WalletScreenViewCashOutBanner(),
                    Container(
                        margin: EdgeInsets.only(left: 5.w, top: 1.5.h),
                        child: WalletScreenViewCashOutText())
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: WalletScreenViewCashOutIcon())
              ],
            )));
  }
}
