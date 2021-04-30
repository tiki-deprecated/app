/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/login/login_otp_valid/login_otp_valid_cubit.dart';
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/src/cupertino/page_scaffold.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_otp_screen_load.dart';

class LoginOtpScreen extends PlatformScaffold {
  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: LoginOtpScreenLoad());
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: LoginOtpScreenLoad());
  }

  Widget _screen(BuildContext context) {
    return BlocListener<LoginOtpValidCubit, LoginOtpValidState>(
        listener: (BuildContext context, LoginOtpValidState state) {
          if (state is LoginOtpValidSuccess)
            Navigator.of(context)
                .pushNamed(ConfigNavigate.path.loginEmail); //TODO fix path
          else if (state is LoginOtpValidFailure)
            Navigator.of(context).pushNamed(ConfigNavigate.path.loginEmail);
        },
        child: LoginOtpScreenLoad());
  }
}
