/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/platform/platform_relative_size.dart';
import 'package:app_stash/src/screen/screen_intro_control.dart';
import 'package:flutter/cupertino.dart';

class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlatformRelativeSize().init(context);
    return ScreenIntroControl();
  }
}
