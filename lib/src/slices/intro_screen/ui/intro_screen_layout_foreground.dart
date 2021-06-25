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
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _foreground(context));
  }

  Widget _foreground(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: service.presenter.marginHorizontal.w),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(top: service.presenter.marginTopSkip.h),
              alignment: Alignment.topRight,
              child: IntroScreenSkipButton()),
          Container(
              margin: EdgeInsets.only(
                  top: service.presenter.marginTopTitle.h,
                  right: service.presenter.marginRightText.w),
              alignment: Alignment.centerLeft,
              child: IntroScreenTitle()),
          Container(
              margin: EdgeInsets.only(
                  top: service.presenter.marginTopText.h,
                  right: service.presenter.marginRightText.w),
              child: IntroScreenSubtitle()),
          Container(
              margin: EdgeInsets.only(
                  top: service.presenter.marginTopText.h,
                  right: service.presenter.marginRightText.w),
              alignment: Alignment.centerLeft,
              child: IntroScreenDots()),
          Container(
              margin: EdgeInsets.only(top: service.presenter.marginTopButton.h),
              alignment: Alignment.centerLeft,
              child: IntroScreenButton()),
        ]));
  }
}
