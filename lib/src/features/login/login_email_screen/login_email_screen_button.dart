/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/login/login_otp_req/login_otp_req_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailScreenButton extends StatelessWidget {
  static const String _text = "CONTINUE";
  static final double _letterSpacing =
      0.05 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSize = 6 * PlatformRelativeSize.blockHorizontal;
  static final double _marginHorizontal =
      10 * PlatformRelativeSize.blockHorizontal;
  static final double _marginVertical =
      2.5 * PlatformRelativeSize.blockVertical;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginOtpReqBloc, LoginOtpReqState>(
        listener: (BuildContext context, LoginOtpReqState state) {
      if (state is LoginOtpReqStateSuccess)
        Navigator.of(context).pushNamed(ConfigNavigate.path.loginInbox);
    }, builder: (BuildContext context, LoginOtpReqState state) {
      return _button(
          context, state is LoginOtpReqStateInProgress ? state.isValid : false);
    });
  }

  Widget _button(BuildContext context, bool isActive) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(10 * PlatformRelativeSize.blockVertical))),
            primary: isActive ? ConfigColor.mardiGras : ConfigColor.mamba),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: _marginVertical, horizontal: _marginHorizontal),
                child: Center(
                    child: Text(_text,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: _fontSize,
                          letterSpacing: _letterSpacing,
                        ))))
          ],
        ),
        onPressed: () {
          if (isActive) {
            LoginOtpReqBloc bloc = BlocProvider.of<LoginOtpReqBloc>(context);
            bloc.add(LoginOtpReqSubmitted(bloc.state.email));
          }
        });
  }
}
