/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';

class LinkAccountViewSee extends StatelessWidget {
  final String type;

  LinkAccountViewSee(this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ConfigColor.white,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 1.75.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("What data does " + type + " hold",
                style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.bold,
                    color: ConfigColor.tikiBlue)),
            Container(
                margin: EdgeInsets.only(left: 2.5.w),
                child: Image(
                  image: AssetImage('res/images/right-arrow.png'),
                  height: 14.sp,
                  fit: BoxFit.fitHeight,
                ))
          ]),
        ));
  }
}
