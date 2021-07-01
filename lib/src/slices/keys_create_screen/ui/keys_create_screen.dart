/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keys_create_screen_layout_background.dart';
import 'keys_create_screen_layout_foreground.dart';

class KeysNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<KeysNewScreenService>(context).generateKeys(context);
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(children: [
      KeysNewScreenBackground(),
      KeysNewScreenForeground()
    ]))));
  }
}
