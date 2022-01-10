/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'md_screen_layout_background.dart';
import 'md_screen_layout_foreground.dart';

class MdScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(children: [
      MdScreenLayoutBackground(),
      MdScreenLayoutForeground(),
    ]))));
  }
}
