/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_email_screen_button.dart';
import 'login_email_screen_cta.dart';
import 'login_email_screen_error.dart';
import 'login_email_screen_input_android.dart';
import 'login_email_screen_input_ios.dart';
import 'login_email_screen_title.dart';

class LoginEmailScreen extends PlatformScaffold {
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCta = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginRightTitle =
      15 * PlatformRelativeSize.blockHorizontal;
  static final double _marginTopBlob = 46 * PlatformRelativeSize.blockVertical;
  static final double _marginTopInput =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopButton = 4 * PlatformRelativeSize.blockVertical;

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _screen(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _screen(context));
  }

  Widget _screen(BuildContext context) {
    return Stack(
      children: [_background(), _foreground(context)],
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConfigColor.serenade,
        ),
        Container(
            margin: EdgeInsets.only(top: _marginTopBlob),
            child: HelperImage('login-blob')),
        Container(
            alignment: Alignment.topRight,
            child: HelperImage('login-pineapple')),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return SingleChildScrollView(
        child: Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal2x),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(
                        top: _marginTopTitle, right: _marginRightTitle),
                    alignment: Alignment.centerLeft,
                    child: LoginEmailScreenTitle()),
                Container(
                    margin: EdgeInsets.only(top: _marginTopCta),
                    alignment: Alignment.centerLeft,
                    child: LoginEmailScreenCta()),
                Container(
                    margin: EdgeInsets.only(top: _marginTopInput),
                    child: Platform.isIOS
                        ? LoginEmailScreenInputIos()
                        : LoginEmailScreenInputAndroid()),
                LoginEmailScreenError(),
                Container(
                    margin: EdgeInsets.only(top: _marginTopButton),
                    child: LoginEmailScreenButton())
              ])))
    ]));
  }
}
