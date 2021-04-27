/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/features/intro_screen_together/intro_screen_together.dart';
import 'package:flutter/widgets.dart';

import '../intro_screen/intro_screen.dart';

class IntroScreenEarn extends IntroScreen {
  IntroScreenEarn()
      : super(ConfigColor.kournikova, ConfigString.introEarn.title,
            ConfigString.introEarn.subtitle, ConfigString.introEarn.button, 1);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                IntroScreenTogether(),
            transitionDuration: Duration(seconds: 0),
            reverseTransitionDuration: Duration(seconds: 0)));
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity < 0) onButtonPressed(context);
    if (dragEndDetails.primaryVelocity > 0) Navigator.pop(context);
  }
}
