/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/config/config_color.dart';
import 'package:app_stash/src/config/config_string.dart';
import 'package:app_stash/src/screen/screen_intro_abstract.dart';
import 'package:app_stash/src/screen/screen_intro_together.dart';
import 'package:flutter/widgets.dart';

class ScreenIntroEarn extends ScreenIntroAbstract {
  ScreenIntroEarn()
      : super(ConfigColor.kournikova, ConfigString.introEarn.title,
            ConfigString.introEarn.subtitle, ConfigString.introEarn.button, 1);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ScreenIntroTogether(),
            transitionDuration: Duration(seconds: 0),
            reverseTransitionDuration: Duration(seconds: 0)));
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity < 0) onButtonPressed(context);
    if (dragEndDetails.primaryVelocity > 0) Navigator.pop(context);
  }
}
