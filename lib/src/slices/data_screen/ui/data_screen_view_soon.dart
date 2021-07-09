/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/data_screen/ui/data_screen_view_soon_icon.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class DataScreenViewSoon extends StatelessWidget {
  static const String _title = "COMING SOON";

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(top: 2.5.h, bottom: 3.5.h, left: 7.w, right: 7.w),
        decoration: BoxDecoration(
          color: ConfigColor.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 2.w,
              offset: Offset(0.75.w, 0.75.w), // Shadow position
            ),
          ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DataScreenViewSoonIcon(
                          image: "account-soon-apple", label: "Apple Mail"),
                      DataScreenViewSoonIcon(
                          image: "account-soon-outlook", label: "Outlook"),
                      DataScreenViewSoonIcon(
                          image: "account-soon-google", label: "Google"),
                      DataScreenViewSoonIcon(
                          image: "account-soon-more", label: "...and More"),
                    ]))
          ],
        ));
  }
}
