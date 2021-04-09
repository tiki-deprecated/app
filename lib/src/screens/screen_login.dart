/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_sizes.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:app/src/screens/screen_login_email.dart';
import 'package:app/src/ui/ui_magiclink_send/ui_magic_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO need a Terms of Service link on this page (or in email?)
class ScreenLogin extends PlatformScaffold {
  static final double _hPadding =
      ConfigSizes.hPadding * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMarginStart =
      15 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMarginBlob =
      46 * PlatformRelativeSize.blockSizeVertical;
  static final double _vMarginPineapple =
      4 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMarginTitleRight =
      15 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fsizeTitle =
      10 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fsizeEmailCta =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  static final Widget _onSubmit = ScreenLoginEmail();

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _stack(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _stack(context));
  }

  Widget _stack(BuildContext context) {
    return Stack(
      children: [_background(), _foreground(context)],
    );
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: _hPadding),
              child: Column(children: [
                _title(),
                _emailCta(),
                Container(
                    margin: EdgeInsets.only(top: _vMargin),
                    child: UIMagicLink(_onSubmit))
              ])))
    ]);
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConfigColors.serenade,
        ),
        Container(
            margin: EdgeInsets.only(top: _vMarginBlob),
            child: Image(image: AssetImage('res/images/login-blob.png'))),
        Container(
          margin: EdgeInsets.only(top: _vMarginPineapple),
          child: Align(
              alignment: Alignment.topRight,
              child:
                  Image(image: AssetImage('res/images/login-pineapple.png'))),
        ),
      ],
    );
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(top: _vMarginStart, right: _vMarginTitleRight),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(ConfigStrings.loginTitle,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fsizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConfigColors.mardiGras))));
  }

  Widget _emailCta() {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(ConfigStrings.loginEmailCta,
                style: TextStyle(
                    fontSize: _fsizeEmailCta,
                    fontWeight: FontWeight.w600,
                    color: ConfigColors.emperor))));
  }
}
