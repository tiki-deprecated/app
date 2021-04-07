/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/helpers/helper_login/helper_login.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:app/src/screens/screen_home.dart';
import 'package:app/src/screens/screen_intro_control.dart';
import 'package:app/src/screens/screen_keys_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenLoginOtp extends PlatformScaffold {
  static final Color _backgroundColor = ConfigColors.sunglow;
  static final Widget _loggedIn = ScreenHome();
  static final Widget _loggedOut = ScreenIntroControl();
  static final Widget _creating = ScreenKeysCreate();

  final String _otp;
  ScreenLoginOtp(this._otp);

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: login(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: login(context));
  }

  Widget login(BuildContext context) {
    return HelperLogin(_otp, _loggedIn, _creating, _loggedOut, _stack(context));
  }

  Widget _stack(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: _backgroundColor)),
      Align(
          alignment: Alignment.topLeft,
          child: Image(image: AssetImage('res/images/splash-blob-tl.png'))),
      Stack(children: [
        Center(
            child: Image(image: AssetImage('res/images/splash-logo-bkg.png'))),
        Center(child: Image(image: AssetImage('res/images/splash-logo.png')))
      ]),
      Align(
          alignment: Alignment.bottomRight,
          child: Image(image: AssetImage('res/images/splash-blob-br.png'))),
    ]);
  }
}
