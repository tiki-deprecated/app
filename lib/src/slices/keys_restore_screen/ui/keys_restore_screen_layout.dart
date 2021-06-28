/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_layout_background.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_layout_foreground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KeysRestoreScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(children: [
      KeysRestoreScreenLayoutBackground(),
      KeysRestoreScreenLayoutForeground(),
    ])));
  }
}
