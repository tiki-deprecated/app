/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/login/login_otp/login_otp_valid/bloc/login_otp_valid_bloc.dart';
import 'package:app/src/slices/app/helper_log_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_otp_screen_load.dart';

class LoginOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginOtpValidBloc, LoginOtpValidState>(
        listener: (BuildContext context, LoginOtpValidState state) {
          if (state is LoginOtpValidSuccess) {
            if (state.hasKeys)
              Navigator.of(context).pushNamed(ConfigNavigate.path.home);
            else
              Navigator.of(context).pushNamed(ConfigNavigate.path.keysNew);
          } else if (state is LoginOtpValidFailure)
            HelperLogOut.provide(context).current(context);
        },
        child: LoginOtpScreenLoad());
  }
}
