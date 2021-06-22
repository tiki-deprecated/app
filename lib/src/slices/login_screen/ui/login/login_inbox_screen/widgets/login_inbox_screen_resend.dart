/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginInboxScreenResend extends StatelessWidget {
  static const String _receive = "Didn't receive it?";
  static const String _resend = "Resend now";
  static final double _fontSize = 5.w;
  static final double _marginRight = 1.w;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(_receive,
          style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600)),
      TextButton(
          onPressed: () {
            // LoginOtpReqBloc bloc = BlocProvider.of<LoginOtpReqBloc>(context);
            // bloc.add(LoginOtpReqSubmitted(bloc.state.email));
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
