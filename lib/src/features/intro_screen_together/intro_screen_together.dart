/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:flutter/widgets.dart';

import '../intro_screen/intro_screen.dart';

class IntroScreenTogether extends IntroScreen {
  IntroScreenTogether()
      : super(
            ConfigColor.macaroniAndCheese,
            ConfigString.introTogether.title,
            ConfigString.introTogether.subtitle,
            ConfigString.introTogether.button,
            2);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(skipToPath);
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity > 0) Navigator.of(context).pop();
  }
}
