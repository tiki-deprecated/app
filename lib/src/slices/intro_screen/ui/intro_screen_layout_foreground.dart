/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../intro_screen_service.dart';
import 'intro_screen_view_button.dart';
import 'intro_screen_view_dots.dart';
import 'intro_screen_view_skip_button.dart';
import 'intro_screen_view_subtitle.dart';
import 'intro_screen_view_title.dart';

class IntroScreenForeground extends StatelessWidget {
  static const num _marginTextRight = 12;
  static const num _marginTextTop = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _foreground(context));
  }

  Widget _foreground(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(top: 2.h),
              alignment: Alignment.topRight,
              child: IntroScreenSkipButton()),
          Container(
              margin: EdgeInsets.only(top: 15.h, right: _marginTextRight.w),
              alignment: Alignment.centerLeft,
              child: IntroScreenTitle()),
          Container(
              margin: EdgeInsets.only(
                  top: _marginTextTop.h, right: _marginTextRight.w),
              child: IntroScreenSubtitle()),
          Container(
              margin: EdgeInsets.only(
                  top: _marginTextTop.h, right: _marginTextRight.w),
              alignment: Alignment.centerLeft,
              child: IntroScreenDots()),
          Container(
              margin: EdgeInsets.only(top: 5.h),
              alignment: Alignment.centerLeft,
              child: IntroScreenButton()),
        ]));
  }
}
