/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:flutter/widgets.dart';

import '../intro_screen.dart';

class IntroScreenEarn extends IntroScreen {

  IntroScreenEarn()
      : super(ConfigColor.kournikova, _title, _subtitle, _button, 1);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            ConfigNavigate.screen.introTogether,
        transitionDuration: Duration(seconds: 0),
        reverseTransitionDuration: Duration(seconds: 0)));
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0) onButtonPressed(context);
    if (dragEndDetails.primaryVelocity! > 0) Navigator.of(context).pop();
  }
}
