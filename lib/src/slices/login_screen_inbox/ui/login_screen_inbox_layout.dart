/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_screen_inbox_layout_background.dart';
import 'login_screen_inbox_layout_foreground.dart';

class LoginScreenInboxLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      LoginScreenInboxLayoutBackground(),
      LoginScreenInboxLayoutForeground(),
    ])));
  }
}
