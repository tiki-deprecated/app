/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/entry.dart';
import 'package:app/src/features/intro/intro_screen_control/intro_screen_control.dart';
import 'package:app/src/features/intro/intro_screen_earn/intro_screen_earn.dart';
import 'package:app/src/features/intro/intro_screen_together/intro_screen_together.dart';
import 'package:app/src/features/keys/keys_new_screen/keys_new_screen.dart';
import 'package:app/src/features/login/login_email_screen/login_email_screen.dart';
import 'package:app/src/features/login/login_inbox_screen/login_inbox_screen.dart';
import 'package:app/src/features/login/login_otp_screen/login_otp_screen.dart';
import 'package:flutter/widgets.dart';

class ConfigNavigate {
  static final GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();
  static const _ConfigNavigatePath path = const _ConfigNavigatePath();
  static final _ConfigNavigateScreen screen = _ConfigNavigateScreen();

  const ConfigNavigate();

  static Map<String, WidgetBuilder> routeTable(BuildContext context) {
    return {
      path.entry: (BuildContext context) => Entry(), //Entry(_user),
      path.introControl: (BuildContext context) => screen.introControl,
      path.introEarn: (BuildContext context) => screen.introEarn,
      path.introTogether: (BuildContext context) => screen.introTogether,
      path.loginEmail: (BuildContext context) => screen.loginEmail,
      path.loginInbox: (BuildContext context) => screen.loginInbox,
      path.loginOtp: (BuildContext context) => screen.loginOtp,
      path.keysNew: (BuildContext context) => screen.keysNew,
    };
  }
}

class _ConfigNavigatePath {
  final String entry = "/";

  final String introControl = "/intro/control";
  final String introEarn = "/intro/earn";
  final String introTogether = "/intro/together";

  final String loginEmail = "/login/email";
  final String loginInbox = "/login/inbox";
  final String loginOtp = "/login/otp";

  final String keysNew = "/keys/new";

  const _ConfigNavigatePath();
}

class _ConfigNavigateScreen {
  final Widget introControl = IntroScreenControl();
  final Widget introEarn = IntroScreenEarn();
  final Widget introTogether = IntroScreenTogether();

  final Widget loginEmail = LoginEmailScreen();
  final Widget loginInbox = LoginInboxScreen();
  final Widget loginOtp = LoginOtpScreen();

  final Widget keysNew = KeysNewScreen();

  _ConfigNavigateScreen();
}
