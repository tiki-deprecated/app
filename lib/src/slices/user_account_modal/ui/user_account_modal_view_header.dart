/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class UserAccountModalViewHeader extends StatelessWidget {
  static const String _text = "Account";
  static const num _paddingHoriz = 6;
  static const num _paddingVert = 2.5;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: Container(
              alignment: Alignment.centerRight,
              child: Container(
                  width: _paddingHoriz.w * 3,
                  height: _paddingVert.h * 3,
                  padding: EdgeInsets.only(right: _paddingHoriz.w),
                  child: Center(
                      child: Image(
                    width: 12.sp,
                    height: 12.sp,
                    image: AssetImage('res/images/icon-x.png'),
                  ))))),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: _paddingVert.h,
          ),
          child: Text(_text,
              style: TextStyle(
                  color: ConfigColor.tikiPurple,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp))),
    ]);
  }
}
