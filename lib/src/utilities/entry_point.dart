/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/screens/screen_intro_control.dart';
import 'package:app/src/screens/screen_splash.dart';
import 'package:app/src/utilities/flutter_fire.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter/widgets.dart';

final Widget _splashScreen = ScreenSplash();
final Widget _loginDetector = ScreenIntroControl();

Widget entryPoint() {
  initUniLinks();
  return FlutterFire(_splashScreen, _loginDetector);
}
