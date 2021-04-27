/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/intro_screen/intro_screen_dots.dart';
import 'package:app/src/features/intro_screen/intro_screen_skip.dart';
import 'package:app/src/features/intro_screen/intro_screen_subtitle.dart';
import 'package:app/src/features/intro_screen/intro_screen_title.dart';
import 'package:app/src/features/login_email_screen/login_email_screen.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'intro_screen_button.dart';

abstract class IntroScreen extends PlatformScaffold {
  static final double _marginTopText = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopButton = 5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopTitle = 20 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSkip = 8 * PlatformRelativeSize.blockVertical;

  static const int screenTotal = 3;
  final Widget skipTo = LoginEmailScreen();

  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String button;
  final int screenPos;

  IntroScreen(this.backgroundColor, this.title, this.subtitle, this.button,
      this.screenPos);

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: screen(context));
  }

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: screen(context));
  }

  Widget screen(BuildContext context) {
    return GestureDetector(
        child: Stack(children: [_background(), _foreground(context)]),
        onHorizontalDragEnd: (dragEndDetails) =>
            onHorizontalDrag(context, dragEndDetails));
  }

  Widget _background() {
    return Stack(children: [
      Center(child: Container(color: backgroundColor)),
      Align(alignment: Alignment.bottomLeft, child: HelperImage('intro-blob')),
      Align(
          alignment: Alignment.bottomRight,
          child: HelperImage('intro-pineapple')),
    ]);
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: _marginTopSkip),
                    alignment: Alignment.topRight,
                    child: IntroScreenSkip(skipTo)),
                Container(
                    margin: EdgeInsets.only(top: _marginTopTitle),
                    alignment: Alignment.centerLeft,
                    child: IntroScreenTitle(title)),
                Container(
                    margin: EdgeInsets.only(top: _marginTopText),
                    child: IntroScreenSubtitle(subtitle)),
                Container(
                    margin: EdgeInsets.only(top: _marginTopText),
                    child: IntroScreenDots(screenTotal, screenPos)),
                Container(
                    margin: EdgeInsets.only(top: _marginTopButton),
                    alignment: Alignment.centerLeft,
                    child: IntroScreenButton(button, onButtonPressed))
              ])))
    ]);
  }

  void onButtonPressed(BuildContext context);

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails);
}
