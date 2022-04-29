/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../bkp/config_color.dart';
import 'data_screen_view_soon_icon.dart';

class DataScreenViewSoon extends StatelessWidget {
  static const String _title = "COMING SOON";

  const DataScreenViewSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(top: 2.5.h, bottom: 3.5.h, left: 7.w, right: 7.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _title,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.sp,
                  color: ConfigColor.tikiBlue),
            ),
            Container(
                margin: EdgeInsets.only(top: 2.5.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      DataScreenViewSoonIcon(
                          image: "account-soon-apple", label: "Apple Mail"),
                      DataScreenViewSoonIcon(
                          image: "account-soon-yahoo", label: "Yahoo"),
                      DataScreenViewSoonIcon(
                          image: "account-soon-more", label: "...and more"),
                    ]))
          ],
        ));
  }
}
