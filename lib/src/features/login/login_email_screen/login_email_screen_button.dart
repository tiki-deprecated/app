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

/// The login screen button.
///
/// The button that starts the login proccess. Uses bloc pattern.
///
/// * See also [LoginOtpReqBloc]
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
    return _blocConsumer(context);
  }

  BlocConsumer _blocConsumer(BuildContext context) {
    return BlocConsumer<LoginOtpReqBloc, LoginOtpReqState>(
        listener: _blocConsumerListener, builder: _blocConsumerBuilder);
  }

  Widget _blocConsumerBuilder(BuildContext context, LoginOtpReqState state) {
    bool isButtonActive =
    state is LoginOtpReqStateInProgress ? state.isValid : false;
    return _button(context, isButtonActive);
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
        onPressed: isActive ? () => _submitLogin(context) : null);
  }

  _submitLogin(BuildContext context) {
    LoginOtpReqBloc bloc = BlocProvider.of<LoginOtpReqBloc>(context);
    bloc.add(LoginOtpReqSubmitted(bloc.state.email));
  }

  _blocConsumerListener(BuildContext context, LoginOtpReqState state) {
    if (state is LoginOtpReqStateSuccess)
      Navigator.of(context).pushNamed(ConfigNavigate.path.loginInbox);
  }

}
