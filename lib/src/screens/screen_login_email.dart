import 'dart:developer';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_sizes.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/utilities/platform_scaffold.dart';
import 'package:app/src/utilities/relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenLoginEmail extends PlatformScaffold {
  static final double _lrPadding =
      ConstantSizes.hPadding * RelativeSize.safeBlockHorizontal;
  static final double _vMarginStart = 15 * RelativeSize.safeBlockVertical;
  static final double _vMargin = 2.5 * RelativeSize.safeBlockVertical;
  static final double _fSizeTitle = 10 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeSubtitle = 5 * RelativeSize.safeBlockHorizontal;
  static final double _fSizeButton = 6 * RelativeSize.safeBlockHorizontal;
  static final double heightButton = 8 * RelativeSize.safeBlockVertical;
  static final double widthButton = 50 * RelativeSize.safeBlockHorizontal;

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
              padding: EdgeInsets.only(left: _lrPadding, right: _lrPadding),
              child: Column(children: [
                _title(),
                _subtitle(),
                Container(
                  margin: EdgeInsets.only(top: _vMargin * 1.5),
                  child: Image(
                    image: AssetImage('res/images/login-email-pineapple.png'),
                  ),
                ),
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

  Widget _button(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: _vMargin * 3),
        child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_vMargin * 2))),
                    primary: ConstantColors.mardiGras),
                child: Container(
                    width: widthButton,
                    height: heightButton,
                    child: Center(
                        child: Text(ConstantStrings.loginEmailButton,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: _fSizeButton,
                                letterSpacing: 1)))),
                onPressed: () => openInbox())));
  }

  void openInbox() {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
      );
      intent.launch().catchError((e) {
        log("Unable to launch inbox", error: e);
      });
    } else if (Platform.isIOS) {
      launch("message://").catchError((e) {
        log("Unable to launch inbox", error: e);
      });
    }
  }
}
