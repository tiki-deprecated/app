/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'keys_save_screen_layout_background.dart';
import 'keys_save_screen_layout_foreground.dart';

class KeysSaveScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      KeysNewScreenLayoutBackground(),
      KeysNewScreenLayoutForeground(),
    ])));
  }
}
