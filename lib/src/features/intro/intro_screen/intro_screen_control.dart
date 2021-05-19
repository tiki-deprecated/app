/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:flutter/widgets.dart';

import 'intro_screen.dart';

class IntroScreenControl extends IntroScreen {
  static const String _title = "Take control of your data";
  static const String _subtitle =
      "TIKI is a free app that allows you to see, control and monetize your data.";
  static const String _button = "NEXT";

  IntroScreenControl()
      : super(ConfigColor.sunglow, _title, _subtitle, _button, 0);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            ConfigNavigate.screen.introEarn,
        transitionDuration: Duration(seconds: 0),
        reverseTransitionDuration: Duration(seconds: 0)));
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0) onButtonPressed(context);
  }
}
