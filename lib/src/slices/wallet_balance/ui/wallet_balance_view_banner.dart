/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:math' as math;

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class WalletBalanceViewBanner extends StatelessWidget {
  static const String _text = "Referrals only";

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      HelperImage("referral-banner"),
      Container(
          margin: EdgeInsets.symmetric(vertical: 2.h),
          child: Transform.rotate(
              angle: -30 * math.pi / 180,
              child: Text(
                _text,
                style: TextStyle(
                    color: ConfigColor.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 8.5.sp),
              ))),
    ]);
  }
}
