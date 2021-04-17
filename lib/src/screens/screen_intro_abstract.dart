/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_sizes.dart';
import 'package:app/src/platform/platform_page_route.dart';
import 'package:app/src/platform/platform_relative_size.dart';
import 'package:app/src/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ScreenIntroAbstract extends PlatformScaffold {
  static final double hPadding =
      ConfigSizes.hPadding * PlatformRelativeSize.safeBlockHorizontal;
  static final double vMargin = 2.5 * PlatformRelativeSize.safeBlockVertical;
  static final double vMarginSkip = 8 * PlatformRelativeSize.safeBlockVertical;
  static final double vMarginTitle =
      20 * PlatformRelativeSize.safeBlockVertical;
  static final double fSizeTitle =
      10 * PlatformRelativeSize.safeBlockHorizontal;
  static final double fSizeSubtitle =
      5 * PlatformRelativeSize.safeBlockHorizontal;
  static final double fSizeButton =
      6 * PlatformRelativeSize.safeBlockHorizontal;
  static final double fSizeSkip = 4 * PlatformRelativeSize.safeBlockHorizontal;
  static final double sizeDot = 1 * PlatformRelativeSize.safeBlockVertical;
  static final double heightButton = 8 * PlatformRelativeSize.safeBlockVertical;
  static final double widthButton =
      50 * PlatformRelativeSize.safeBlockHorizontal;

  final String _titleText;
  final String _subtitleText;
  final String _buttonText;
  final int _dotFilled;
  final int _dotTotal;

  ScreenIntroAbstract(this._titleText, this._subtitleText, this._buttonText,
      this._dotFilled, this._dotTotal);

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: stack(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: stack(context));
  }

  Widget title() {
    return Container(
        margin: EdgeInsets.only(top: vMarginTitle),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_titleText,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: fSizeTitle,
                    fontWeight: FontWeight.bold))));
  }

  Widget subtitle() {
    return Container(
        margin: EdgeInsets.only(top: vMargin),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_subtitleText,
                style: GoogleFonts.nunitoSans(
                    fontSize: fSizeSubtitle, fontWeight: FontWeight.bold))));
  }

  Widget dots() {
    List<Widget> dots = List.generate(
        _dotTotal, (i) => _dot(i == _dotFilled - 1 ? true : false));
    return Container(
        margin: EdgeInsets.only(top: vMargin),
        child: Row(
          children: dots,
        ));
  }

  Widget _dot(bool active) {
    return Container(
      height: sizeDot,
      width: sizeDot,
      margin: EdgeInsets.symmetric(horizontal: sizeDot * 0.5),
      decoration: BoxDecoration(
          color: active ? ConfigColors.mardiGras : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(sizeDot * 2))),
    );
  }

  Widget button(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: vMargin * 2),
        child: Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(vMargin * 2))),
                    primary: ConfigColors.mardiGras),
                child: Container(
                    width: widthButton,
                    height: heightButton,
                    child: Center(
                        child: Text(_buttonText,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: fSizeButton,
                              letterSpacing: 0.05 *
                                  PlatformRelativeSize.safeBlockHorizontal,
                            )))),
                onPressed: () {
                  buttonPressed(context);
                })));
  }

  Widget skip(BuildContext context, Widget to) {
    return Container(
        margin: EdgeInsets.only(top: vMarginSkip),
        child: Align(
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, platformPageRoute(to));
                },
                child: Text('Skip',
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: fSizeSkip)))));
  }

  Widget stack(BuildContext context);

  void buttonPressed(BuildContext context);
}
