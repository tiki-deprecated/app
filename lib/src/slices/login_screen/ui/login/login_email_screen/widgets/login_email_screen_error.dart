/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/login/login_otp/login_otp_req/bloc/login_otp_req_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginEmailScreenError extends StatelessWidget {
  static const String _text = "Please enter a valid email";
  static final double _fontSize = 4.w;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginOtpReqBloc, LoginOtpReqState>(
        builder: (BuildContext context, LoginOtpReqState state) {
      return _textWidget(state is LoginOtpReqStateFailure);
    });
  }

  Widget _textWidget(bool isError) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _text,
          style: TextStyle(
              fontSize: isError ? _fontSize : 0,
              fontWeight: FontWeight.w500,
              color: isError ? ConfigColor.grenadier : ConfigColor.serenade),
        ));
  }
}
