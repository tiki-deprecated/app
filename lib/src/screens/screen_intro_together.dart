/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/constants/constant_colors.dart';
import 'package:app/src/constants/constant_strings.dart';
import 'package:app/src/screens/screen_intro_abstract.dart';
import 'package:app/src/screens/screen_login.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenIntroTogether extends ScreenIntroAbstract {
  static final int _dotFilled = 3;
  static final int _dotTotal = 3;
  static final Widget _nextScreen = ScreenLogin();
  static final Color _backgroundColor = ConstantColors.macaroniAndCheese;

  ScreenIntroTogether()
      : super(ConstantStrings.intro3Title, ConstantStrings.intro3Subtitle,
            ConstantStrings.intro3ButtonText, _dotFilled, _dotTotal);

  @override
  Widget stack(BuildContext context) {
    return GestureDetector(
      child: Stack(children: [_background(), _foreground(context)]),
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity > 0) Navigator.pop(context);
      },
    );
  }

  @override
  void buttonPressed(BuildContext context) {
    Navigator.push(context, platformPageRoute(_nextScreen));
  }

  Widget _background() {
    return Stack(children: [
      Center(child: Container(color: _backgroundColor)),
      Align(
          alignment: Alignment.bottomLeft,
          child: Image(image: AssetImage('res/images/intro-blob.png'))),
      Align(
          alignment: Alignment.bottomRight,
          child: Image(image: AssetImage('res/images/intro-pineapple-90.png'))),
    ]);
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenIntroAbstract.hPadding),
              child: Column(
                  children: [title(), subtitle(), dots(), button(context)])))
    ]);
  }
}
