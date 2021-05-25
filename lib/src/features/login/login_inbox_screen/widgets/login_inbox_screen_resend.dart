/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/login/login_otp/login_otp_req/bloc/login_otp_req_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginInboxScreenResend extends StatelessWidget {
  static const String _receive = "Didn't receive it?";
  static const String _resend = "Resend now";
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;
  static final double _marginRight = 1 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(_receive,
          style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600)),
      TextButton(
          onPressed: () {
            LoginOtpReqBloc bloc = BlocProvider.of<LoginOtpReqBloc>(context);
            bloc.add(LoginOtpReqSubmitted(bloc.state.email));
          },
          child: Row(children: [
            Container(
                margin: EdgeInsets.only(right: _marginRight),
                child: Text(_resend,
                    style: TextStyle(
                        fontSize: _fontSize,
                        fontWeight: FontWeight.bold,
                        color: ConfigColor.orange))),
            HelperImage("inbox-resend")
          ]))
    ]);
  }
}
