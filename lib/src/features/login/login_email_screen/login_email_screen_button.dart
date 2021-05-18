/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/login/login_otp_req/login_otp_req_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_big_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return _blocConsumer(context);
  }

  BlocConsumer _blocConsumer(BuildContext context) {
    return BlocConsumer<LoginOtpReqBloc, LoginOtpReqState>(
        listener: _blocConsumerListener, builder: _blocConsumerBuilder);
  }

  _blocConsumerListener(BuildContext context, LoginOtpReqState state) {
    if (state is LoginOtpReqStateSuccess)
      Navigator.of(context).pushNamed(ConfigNavigate.path.loginInbox);
  }

  Widget _blocConsumerBuilder(BuildContext context, LoginOtpReqState state) {
    bool isButtonActive =
    state is LoginOtpReqStateInProgress ? state.isValid : false;
    return _button(context, isButtonActive);
  }

  Widget _button(BuildContext context, bool isActive) {
    return TikiBigButton(_text, isActive, _submitLogin);
  }

  _submitLogin(BuildContext context) {
    Navigator.of(context).pushNamed(ConfigNavigate.path.loginInbox);
    LoginOtpReqBloc bloc = BlocProvider.of<LoginOtpReqBloc>(context);
    bloc.add(LoginOtpReqSubmitted(bloc.state.email));
  }
}
