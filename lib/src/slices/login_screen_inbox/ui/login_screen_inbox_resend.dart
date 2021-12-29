/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';
import '../login_screen_inbox_service.dart';

class LoginScreenInboxResend extends StatelessWidget {
  static const num _fontSize = 14;
  static const String _textReceive = "Didn't receive it?";
  static const String _textResend = "Resend now";

  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<LoginScreenInboxService>(context, listen: false).controller;
    return Row(children: [
      Text(_textReceive,
          style: TextStyle(
              color: ConfigColor.greySeven,
              fontSize: _fontSize.sp,
              fontWeight: FontWeight.w600)),
      TextButton(
          onPressed: () => controller.resend(),
          child: Row(children: [
            Container(
                margin: EdgeInsets.only(right: 1.w),
                child: Text(_textResend,
                    style: TextStyle(
                        fontSize: _fontSize.sp,
                        fontWeight: FontWeight.bold,
                        color: ConfigColor.orange))),
            HelperImage("inbox-resend", height: _fontSize.sp)
          ]))
    ]);
  }
}
