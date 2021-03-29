/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_sizes.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:app/src/ui/ui_deeplink_inbox/ui_deeplink_inbox.dart';

class ScreenLoginEmail extends PlatformScaffold {
  static final double _hPadding =
      ConstantSizes.hPadding * PlatformRelativeSize.safeBlockHorizontal;
  static final double _vMarginStart =
      15 * PlatformRelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * PlatformRelativeSize.safeBlockVertical;
  static final double _fSizeTitle =
      10 * PlatformRelativeSize.safeBlockHorizontal;
  static final double _fSizeSubtitle =
      5 * PlatformRelativeSize.safeBlockHorizontal;

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
                _subtitle(),
                _image(),
                _button(context)
              ])))
    ]);
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConstantColors.serenade,
        ),
        Container(
            child: Align(
                alignment: Alignment.topRight,
                child: Image(
                    image: AssetImage('res/images/login-email-blob-tr.png')))),
        Container(
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Image(
                    image: AssetImage('res/images/login-email-blob-bl.png')))),
      ],
    );
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(top: _vMarginStart),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(ConstantStrings.loginEmailTitle,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantColors.mardiGras))));
  }

  Widget _subtitle() {
    return Container(
        margin: EdgeInsets.only(top: _vMargin),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(ConstantStrings.loginEmailSubtitle,
                style: TextStyle(
                    fontSize: _fSizeSubtitle,
                    fontWeight: FontWeight.w600,
                    color: ConstantColors.emperor))));
  }

  Widget _image() {
    return Container(
      margin: EdgeInsets.only(top: _vMargin * 1.5),
      child: Image(
        image: AssetImage('res/images/login-email-pineapple.png'),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin * 3),
        child: Align(alignment: Alignment.center, child: UIDeeplinkInbox()));
  }
}
