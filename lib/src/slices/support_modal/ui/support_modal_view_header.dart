/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../../../utils/helper_image.dart';

class SupportModalViewHeader extends StatelessWidget {
  static const String _text = "Help Center";
  static const num _paddingHoriz = 6;
  static const num _paddingVert = 3;

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
                      child: HelperImage(
                    "icon-x",
                    width: 20.sp,
                    height: 20.sp,
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
                  fontFamily: ConfigFont.familyNunitoSans,
                  fontSize: 13.sp))),
    ]);
  }
}
