/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/intro_screen_control/intro_screen_control.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    return IntroScreenControl();
  }
}
