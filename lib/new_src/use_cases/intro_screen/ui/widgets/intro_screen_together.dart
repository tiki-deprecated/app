/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';

import '../intro_screen.dart';

class IntroScreenTogether extends IntroScreen {
  static const String _title = "";
  static const String _subtitle =
      "";
  static const String _button = "";

  IntroScreenTogether()
      : super(ConfigColor.macaroniAndCheese, _title, _subtitle, _button, 2);

  @override
  void onButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(skipToPath);
  }

  @override
  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity! > 0) Navigator.of(context).pop();
  }
}
