/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/configs/config_colors.dart';
import 'package:app/src/configs/config_strings.dart';
import 'package:app/src/screens/screen_intro_abstract.dart';
import 'package:app/src/screens/screen_intro_earn.dart';
import 'package:app/src/screens/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenIntroControl extends ScreenIntroAbstract {
  static final int _dotFilled = 1;
  static final int _dotTotal = 3;
  static final Widget _nextScreen = ScreenIntroEarn();
  static final Widget _skipTo = ScreenLogin();
  static final Color _backgroundColor = ConfigColors.sunglow;

  ScreenIntroControl()
      : super(ConfigStrings.intro1Title, ConfigStrings.intro1Subtitle,
            ConfigStrings.intro1ButtonText, _dotFilled, _dotTotal);

  @override
  Widget stack(BuildContext context) {
    return GestureDetector(
      child: Stack(children: [_background(), _foreground(context)]),
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity < 0) buttonPressed(context);
      },
    );
  }

  @override
  void buttonPressed(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => _nextScreen,
            transitionDuration: Duration(seconds: 0),
            reverseTransitionDuration: Duration(seconds: 0)));
  }

  Widget _background() {
    return Stack(children: [
      Center(child: Container(color: _backgroundColor)),
      Align(
          alignment: Alignment.bottomLeft,
          child: Image(image: AssetImage('res/images/intro-blob.png'))),
      Align(
          alignment: Alignment.bottomRight,
          child: Image(image: AssetImage('res/images/intro-pineapple.png'))),
    ]);
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenIntroAbstract.hPadding),
              child: Column(children: [
                skip(context, _skipTo),
                title(),
                subtitle(),
                dots(),
                button(context)
              ])))
    ]);
  }
}
