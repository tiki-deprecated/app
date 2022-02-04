/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class UserReferralViewText extends StatelessWidget {
  static const String _textL1 = "Share your TIKI code and get";
  static const String _textL2 = "\$5 for every 10 people who join.";
  static const num _fontSize = 11;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _textL1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: _fontSize.sp,
              fontWeight: FontWeight.w600,
              color: ConfigColor.tikiBlue),
        ),
        Text(
          _textL2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: _fontSize.sp,
              fontWeight: FontWeight.w800,
              color: ConfigColor.tikiBlue),
        )
      ],
    );
  }
}
