/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'md_screen_view_back_button.dart';
import 'md_screen_view_md.dart';

class MdScreenLayoutForeground extends StatelessWidget {
  static const num _marginTop = 2;
  static const num _marginBottom = 12;
  static const num _marginHorizontal = 6;
  static const num _marginBackLeft = 3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Container(
          margin: EdgeInsets.only(left: _marginBackLeft.w),
          child: MdScreenViewBackButton()),
      Expanded(
          child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(
                      top: _marginTop.h,
                      bottom: _marginBottom.h,
                      left: _marginHorizontal.w,
                      right: _marginHorizontal.w),
                  child: MdScreenView())))
    ]));
  }
}
