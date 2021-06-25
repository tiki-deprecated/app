/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_screen/ui/login_screen_inbox_back_button.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';
import 'login_screen_inbox_resend.dart';
import 'login_screen_inbox_sent_to.dart';
import 'login_screen_inbox_title.dart';

class LoginScreenForegroundInbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context, listen: false);
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
                left: service.presenter.marginBackLeft.w,
                right: service.presenter.marginHorizontal.w),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              LoginScreenInboxBackButton(),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                          left: service.presenter.marginBackLeft.w),
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Container(
                            margin: EdgeInsets.only(
                                top: service.presenter.marginTitleInboxTop.h),
                            alignment: Alignment.centerLeft,
                            child: LoginScreenInboxTitle()),
                        Expanded(child: HelperImage("inbox-pineapple")),
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: LoginScreenInboxSentTo()),
                        Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(
                                bottom: service.presenter.marginResendBottom.h),
                            child: LoginScreenInboxResend())
                      ])))
            ])));
  }
}
