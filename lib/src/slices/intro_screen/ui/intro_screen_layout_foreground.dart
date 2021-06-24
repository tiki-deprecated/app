/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import 'intro_screen_view_button.dart';
import 'intro_screen_view_dots.dart';
import 'intro_screen_view_skip_button.dart';
import 'intro_screen_view_subtitle.dart';
import 'intro_screen_view_title.dart';

class IntroScreenForeground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _foreground(context));
  }

  Widget _foreground(BuildContext context) {
    return Column(children: [
      IntroScreenSkipButton(),
      IntroScreenTitle(),
      IntroScreenSubtitle(),
      IntroScreenDots(),
      IntroScreenButton(),
    ]);
  }
}
