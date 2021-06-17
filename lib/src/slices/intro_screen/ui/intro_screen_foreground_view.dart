/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import 'intro_screen_button.dart';
import 'intro_screen_dots.dart';
import 'intro_screen_skip_button.dart';
import 'intro_screen_subtitle.dart';
import 'intro_screen_title.dart';

class IntroScreenForegroundView extends StatelessWidget {

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