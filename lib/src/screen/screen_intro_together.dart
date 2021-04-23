/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/config/config_color.dart';
import 'package:app_stash/src/config/config_string.dart';
import 'package:app_stash/src/platform/platform_page_route.dart';
import 'package:app_stash/src/screen/screen_intro_abstract.dart';
import 'package:flutter/widgets.dart';

class ScreenIntroTogether extends ScreenIntroAbstract {
  ScreenIntroTogether()
      : super(
            ConfigColor.macaroniAndCheese,
            ConfigString.introTogether.title,
            ConfigString.introTogether.subtitle,
            ConfigString.introTogether.button,
            2);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.push(context, PlatformPageRoute.screen(skipTo));
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity > 0) Navigator.pop(context);
  }
}
