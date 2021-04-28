/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

import 'features/intro_screen_control/intro_screen_control.dart';
import 'utils/platform/platform_relative_size.dart';

class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    return IntroScreenControl();
  }
}
