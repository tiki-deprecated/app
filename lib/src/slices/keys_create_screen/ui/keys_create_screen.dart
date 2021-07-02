/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_create_screen_service.dart';
import 'keys_create_screen_layout_background.dart';
import 'keys_create_screen_layout_foreground.dart';

class KeysCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<KeysCreateScreenService>(context, listen: false)
        .generateKeys(context);
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(children: [
      KeysCreateScreenBackground(),
      KeysCreateScreenForeground()
    ]))));
  }
}
