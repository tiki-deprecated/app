/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/features/login_otp_req/login_otp_req_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailScreenInputIos extends StatelessWidget {
  static final double _paddingHorizontal =
      4 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingVertical = 2 * PlatformRelativeSize.blockVertical;
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginOtpReqBloc, LoginOtpReqState>(
        builder: (BuildContext context, LoginOtpReqState state) {
      return _input(context, state is LoginOtpReqStateFailure);
    });
  }

  Widget _input(BuildContext context, bool isError) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(
          horizontal: _paddingHorizontal, vertical: _paddingVertical),
      placeholder: ConfigString.loginEmail.placeholder,
      autocorrect: false,
      autofocus: true,
      placeholderStyle: TextStyle(
          color: ConfigColor.gray,
          fontWeight: FontWeight.bold,
          fontSize: _fontSize),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
      cursorColor: ConfigColor.orange,
      decoration: BoxDecoration(
          color: ConfigColor.white,
          border: Border(
              bottom: BorderSide(
                  color:
                      isError ? ConfigColor.grenadier : ConfigColor.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: (input) {
        BlocProvider.of<LoginOtpReqBloc>(context)
            .add(LoginOtpReqChanged(input));
      },
    );
  }
}
