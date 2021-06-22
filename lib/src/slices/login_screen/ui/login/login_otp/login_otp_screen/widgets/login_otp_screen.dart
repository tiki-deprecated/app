/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_otp_screen_load.dart';

class LoginOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginOtpScreenLoad();
    //Navigator.of(context).pushNamed(AppRouter.);
    // Navigator.of(context).pushNamed(ConfigNavigate.path.keysNew);
    // HelperLogOut.provide(context).current(context);
  }
}
