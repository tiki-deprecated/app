/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keys_create_screen_layout_background.dart';
import 'keys_create_screen_layout_foreground.dart';

class KeysNewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KeysNewScreen();
}

class _KeysNewScreen extends State<KeysNewScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<KeysNewScreenService>(context).generateKeys(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(children: [
      KeysNewScreenBackground(),
      KeysNewScreenForeground()
    ]))));
  }
}
