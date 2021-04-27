/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/features/intro_screen_earn/intro_screen_earn.dart';
import 'package:flutter/widgets.dart';

import '../intro_screen/intro_screen.dart';

class IntroScreenControl extends IntroScreen {
  IntroScreenControl()
      : super(
            ConfigColor.sunglow,
            ConfigString.introControl.title,
            ConfigString.introControl.subtitle,
            ConfigString.introControl.button,
            0);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => IntroScreenEarn(),
            transitionDuration: Duration(seconds: 0),
            reverseTransitionDuration: Duration(seconds: 0)));
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity < 0) onButtonPressed(context);
  }
}
