/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import 'login_screen_inbox_back_button.dart';
import 'login_screen_inbox_resend.dart';
import 'login_screen_inbox_sent_to.dart';
import 'login_screen_inbox_title.dart';

class LoginScreenInboxLayoutForeground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 3.w, right: 6.w),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              LoginScreenInboxBackButton(),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 3.w),
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Container(
                            margin: EdgeInsets.only(top: 2.h),
                            alignment: Alignment.centerLeft,
                            child: LoginScreenInboxTitle()),
                        Expanded(child: HelperImage("inbox-pineapple")),
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: LoginScreenInboxSentTo()),
                        Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(bottom: 15.h),
                            child: LoginScreenInboxResend())
                      ])))
            ])));
  }
}
