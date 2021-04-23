/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/config/config_color.dart';
import 'package:app_stash/src/config/config_string.dart';
import 'package:app_stash/src/screen/screen_intro_abstract.dart';
import 'package:app_stash/src/screen/screen_intro_earn.dart';
import 'package:flutter/widgets.dart';

class ScreenIntroControl extends ScreenIntroAbstract {
  ScreenIntroControl()
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
            pageBuilder: (context, animation1, animation2) => ScreenIntroEarn(),
            transitionDuration: Duration(seconds: 0),
            reverseTransitionDuration: Duration(seconds: 0)));
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity < 0) onButtonPressed(context);
  }
}
