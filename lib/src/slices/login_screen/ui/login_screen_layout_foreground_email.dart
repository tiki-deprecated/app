/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';
import 'login_screen_view_button.dart';
import 'login_screen_view_error.dart';
import 'login_screen_view_input.dart';
import 'login_screen_view_subtitle.dart';
import 'login_screen_view_title.dart';
import 'loginl_screen_view_tos.dart';

class LoginScreenForegroundEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context, listen: false);
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: service.presenter.marginHorizontal.w),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  margin: EdgeInsets.only(
                      top: service.presenter.marginTitleTop.h,
                      right: service.presenter.marginTitleRight.w),
                  alignment: Alignment.centerLeft,
                  child: LoginScreenViewTitle()),
              Container(
                  margin:
                      EdgeInsets.only(top: service.presenter.marginCtaTop.h),
                  alignment: Alignment.centerLeft,
                  child: LoginScreenViewSubtitle()),
              Container(
                  margin:
                      EdgeInsets.only(top: service.presenter.marginInputTop.h),
                  child: LoginScreenViewInput()),
              Align(
                  alignment: Alignment.centerLeft,
                  child: LoginScreenViewError()),
              Container(
                  margin:
                      EdgeInsets.only(top: service.presenter.marginButtonTop.h),
                  child: LoginScreenViewButton()),
              Container(
                  margin:
                      EdgeInsets.only(top: service.presenter.marginTosTop.h),
                  child: LoginScreenViewTos()),
            ])));
  }
}
