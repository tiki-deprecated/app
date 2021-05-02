/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/home/home_screen/home_screen.dart';
import 'package:app/src/features/login/login_email_screen/login_email_screen.dart';
import 'package:app/src/utils/dynamic_link_handler.dart';
import 'package:app/src/utils/helper/helper_log_in.dart';
import 'package:flutter/cupertino.dart';

import 'features/intro/intro_screen_control/intro_screen_control.dart';
import 'utils/platform/platform_relative_size.dart';

class Entry extends StatelessWidget {
  final HelperLogIn _helperLogIn;

  Entry(this._helperLogIn);

  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    return DynamicLinkHandler(child: _route());
  }

  Widget _route() {
    if (_helperLogIn.isReturning()) {
      if (_helperLogIn.isLoggedIn())
        return HomeScreen();
      else
        return LoginEmailScreen();
    } else
      return IntroScreenControl();
  }
}
