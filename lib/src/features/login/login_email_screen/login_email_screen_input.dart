/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/login/login_otp_req/login_otp_req_bloc.dart';
import 'package:app/src/widgets/components/tiki_big_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailScreenInput extends StatelessWidget {
  static const String _placeholder = "Your email";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginOtpReqBloc, LoginOtpReqState>(
        builder: (BuildContext context, LoginOtpReqState state) {
      return TikiBigInput(
          placeholder: _placeholder,
          isError: state is LoginOtpReqStateFailure,
          onChanged: onChanged);
    });
  }

  onChanged(context, input) {
    BlocProvider.of<LoginOtpReqBloc>(context).add(LoginOtpReqChanged(input));
  }
}
