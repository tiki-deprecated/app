/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_email_service.dart';

/// The login screen button.
///
/// The button that starts the login proccess. Uses bloc pattern.
///
/// * See also [LoginOtpReqBloc]
class LoginScreenEmailViewButton extends StatelessWidget {
  static const String _text = "CONTINUE";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenEmailService>(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 15.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.tikiPurple),
        child: Text(_text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ConfigColor.white,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
              letterSpacing: 0.05.w,
            )),
        onPressed: service.model.canSubmit
            ? () => service.controller.submitLogin()
            : null);
  }
}
