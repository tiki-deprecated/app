/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/entry.dart';
import 'package:app_stash/src/screen/screen_intro_control.dart';
import 'package:app_stash/src/screen/screen_intro_earn.dart';
import 'package:app_stash/src/screen/screen_intro_together.dart';
import 'package:flutter/widgets.dart';

class ConfigNavigate {
  static final GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();
  static const _ConfigNavigatePath path = const _ConfigNavigatePath();
  static final _ConfigNavigateScreen screen = _ConfigNavigateScreen();

  const ConfigNavigate();

  static Map<String, WidgetBuilder> routeTable(BuildContext context) {
    return {
      path.entry: (BuildContext context) => Entry(), //Entry(_user),
      path.loginOtp: (BuildContext context) => screen.loginOtp
    };
  }
}

class _ConfigNavigatePath {
  final String entry = "/";

  final String introControl = "/intro/control";
  final String introEarn = "/intro/earn";
  final String introTogether = "/intro/together";

  final String loginOtp = "/login/otp";

  const _ConfigNavigatePath();
}

class _ConfigNavigateScreen {
  final Widget introControl = ScreenIntroControl();
  final Widget introEarn = ScreenIntroEarn();
  final Widget introTogether = ScreenIntroTogether();

  final Widget loginOtp = Text("");

  _ConfigNavigateScreen();
}
