/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_screen_email/ui/login_screen_email_layout_background.dart';
import 'package:app/src/slices/login_screen_email/ui/login_screen_email_layout_foreground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
