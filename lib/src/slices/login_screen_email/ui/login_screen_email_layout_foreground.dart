/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'login_screen_email_view_button.dart';
import 'login_screen_email_view_error.dart';
import 'login_screen_email_view_input.dart';
import 'login_screen_email_view_subtitle.dart';
import 'login_screen_email_view_title.dart';
import 'loginl_screen_email_view_tos.dart';

class LoginScreenEmailLayoutForeground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  margin: EdgeInsets.only(top: 5.h, right: 20.w),
                  alignment: Alignment.centerLeft,
                  child: LoginScreenEmailViewTitle()),
              Container(
                  margin: EdgeInsets.only(top: 2.h),
                  alignment: Alignment.centerLeft,
                  child: LoginScreenEmailViewSubtitle()),
              Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: LoginScreenEmailViewInput()),
              Align(
                  alignment: Alignment.centerLeft,
                  child: LoginScreenEmailViewError()),
              Container(
                  margin: EdgeInsets.only(top: 1.h),
                  child: LoginScreenEmailViewButton()),
              Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: LoginScreenEmailViewTos()),
            ])));
  }
}
