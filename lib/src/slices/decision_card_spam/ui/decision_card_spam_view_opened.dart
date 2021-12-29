/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';

class DecisionCardSpamViewOpened extends StatelessWidget {
  final double? percent;

  DecisionCardSpamViewOpened(this.percent);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("You've opened",
          style: TextStyle(
              fontFamily: ConfigFont.familyNunitoSans,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: ConfigColor.tikiBlue)),
      Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          height: 8.h,
          width: 8.h,
          child: Stack(children: [
            Center(
                child: RichText(
                    text: TextSpan(
                        text:
                            "${(this.percent! * 100).round().toString()}", //TODO FIX!
                        style: TextStyle(
                            color: _getProgressColor(this.percent! * 100),
                            fontFamily: ConfigFont.familyKoara,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                        children: [
                  TextSpan(
                    text: " ",
                    style: TextStyle(fontSize: 6.sp),
                  ),
                  TextSpan(
                    text: "%",
                    style: TextStyle(
                        fontFamily: ConfigFont.familyNunitoSans,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w800),
                  )
                ]))),
            SizedBox(
              height: 8.h,
              width: 8.h,
              child: CircularProgressIndicator(
                  strokeWidth: 1.75.w,
                  backgroundColor: Color(0xFFC4C4C4),
                  value: this.percent,
                  color: _getProgressColor(this.percent! * 100)),
            )
          ])),
      Text("of their emails",
          style: TextStyle(
              fontFamily: ConfigFont.familyNunitoSans,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: ConfigColor.tikiBlue))
    ]);
  }

  _getProgressColor(percent) {
    if (percent <= 50) {
      return ConfigColor.tikiOrange;
    } else {
      return ConfigColor.green;
    }
  }
}
