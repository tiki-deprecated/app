/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';

class DecisionCardSpamViewSent extends StatelessWidget {
  final int? totalEmails;
  final String? sinceYear;

  DecisionCardSpamViewSent(this.totalEmails, this.sinceYear);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("They've sent you",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ConfigColor.tikiBlue,
                fontSize: 10.sp)),
        Padding(padding: EdgeInsets.only(bottom: 0.25.h)),
        Text(
          this.totalEmails.toString(),
          style: TextStyle(
              fontFamily: ConfigFont.familyKoara,
              fontSize: 45.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
            this.totalEmails != null && this.totalEmails! > 1
                ? "emails"
                : "email",
            style: TextStyle(
                height: 0.5, fontWeight: FontWeight.w800, fontSize: 10.sp)),
        Padding(padding: EdgeInsets.only(bottom: 1.75.h)),
        ClipRRect(
            borderRadius: BorderRadius.circular(1.5.w),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 2.w),
                color: ConfigColor.tikiBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        child: Icon(Icons.calendar_today,
                            color: ConfigColor.white, size: 9.sp),
                        padding: EdgeInsets.only(right: 0.5.w)),
                    Text(
                      " since ${this.sinceYear.toString()}",
                      style: TextStyle(
                          color: ConfigColor.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                )))
      ],
    );
  }
}
