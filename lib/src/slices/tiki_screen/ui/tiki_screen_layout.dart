/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/tiki_screen/ui/tiki_screen_layout_background.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_layout_foreground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TikiScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(children: [
      TikiScreenLayoutBackground(),
      TikiScreenLayoutForeground()
    ]))));
  }
}
