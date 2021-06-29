/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';

class LoginScreenInboxResend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    var presenter = service.presenter;
    return Row(children: [
      Text(presenter.textReceive,
          style: TextStyle(
              color: ConfigColor.emperor,
              fontSize: presenter.fontSizeResend.sp,
              fontWeight: FontWeight.w600)),
      TextButton(
          onPressed: () => service.controller.resend(context),
          child: Row(children: [
            Container(
                margin: EdgeInsets.only(right: presenter.marginResendRight.w),
                child: Text(presenter.textResend,
                    style: TextStyle(
                        fontSize: presenter.fontSizeResend.sp,
                        fontWeight: FontWeight.bold,
                        color: ConfigColor.orange))),
            HelperImage("inbox-resend")
          ]))
    ]);
  }
}
