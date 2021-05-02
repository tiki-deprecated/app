/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/features/login/login_otp_valid/login_otp_valid_bloc.dart';
import 'package:app/src/utils/helper/helper_log_out.dart';
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
    return Scaffold(body: _screen(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _screen(context));
  }

  Widget _screen(BuildContext context) {
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
