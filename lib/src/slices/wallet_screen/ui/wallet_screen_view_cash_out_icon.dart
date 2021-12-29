/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';

class WalletScreenViewCashOutIcon extends StatelessWidget {
  static const String _text = "Cash out";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(1.25.h),
              decoration: BoxDecoration(
                  color: ConfigColor.greyFour,
                  borderRadius: BorderRadius.circular(20.w),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2.w,
                      offset: Offset(0.75.w, 0.75.w), // Shadow position
                    ),
                  ]),
              child: Center(child: HelperImage("upload-icon")),
            )
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 0.75.h),
            child: Text(
              _text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: ConfigColor.greyFive),
            ))
      ],
    );
  }
}
