/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constants_colors.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ScreenIntroAbstract extends PlatformScaffold {
  static final double lrPadding = 8 * RelativeSize.safeBlockHorizontal;
  static final double vMargin = 2.5 * RelativeSize.safeBlockVertical;
  static final double vMarginStart = 35 * RelativeSize.safeBlockVertical;
  static final double fsizeTitle = 10 * RelativeSize.safeBlockHorizontal;
  static final double fsizeSubtitle = 5 * RelativeSize.safeBlockHorizontal;
  static final double fsizeButton = 6 * RelativeSize.safeBlockHorizontal;
  static final double sizeDot = 1 * RelativeSize.safeBlockVertical;
  static final double heightButton = 8 * RelativeSize.safeBlockVertical;
  static final double widthButton = 50 * RelativeSize.safeBlockHorizontal;

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
        margin: EdgeInsets.only(top: vMarginStart),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_titleText,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: fsizeTitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantsColors.MARDI_GRAS))));
  }

  Widget subtitle() {
    return Container(
        margin: EdgeInsets.only(top: vMargin),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_subtitleText,
                style: GoogleFonts.nunitoSans(
                    fontSize: fsizeSubtitle,
                    fontWeight: FontWeight.bold,
                    color: ConstantsColors.MARDI_GRAS))));
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
      margin: EdgeInsets.only(left: sizeDot * 0.5, right: sizeDot * 0.5),
      decoration: BoxDecoration(
          color: active ? ConstantsColors.MARDI_GRAS : Colors.white,
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
                    primary: ConstantsColors.MARDI_GRAS),
                child: Container(
                    width: widthButton,
                    height: heightButton,
                    child: Center(
                        child: Text(_buttonText,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w800,
                                fontSize: fsizeButton,
                                letterSpacing: 1)))),
                onPressed: () {
                  buttonPressed(context);
                })));
  }

  Widget stack(BuildContext context);

  void buttonPressed(BuildContext context);
}
