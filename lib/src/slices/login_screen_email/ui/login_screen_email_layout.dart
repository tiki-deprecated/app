/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'login_screen_email_layout_background.dart';
import 'login_screen_email_layout_foreground.dart';

class LoginScreenEmailLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      LoginScreenEmailLayoutBackground(),
      LoginScreenEmailLayoutForeground()
    ])));
  }
}
