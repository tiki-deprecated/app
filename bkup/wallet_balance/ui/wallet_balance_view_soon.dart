/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class WalletBalanceViewSoon extends StatelessWidget {
  static const String _text = "You’ll be able to \nsell your data soon";

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Image(
            image: AssetImage('res/images/info-icon.png'),
            width: 13.sp,
            fit: BoxFit.cover,
          )),
          Container(
              margin: EdgeInsets.only(top: 0.75.h),
              child: Text(
                _text,
                style: TextStyle(
                    color: ConfigColor.tikiBlue,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    fontSize: 11.sp),
              ))
        ]);
  }
}
