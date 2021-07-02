/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_save_screen_service.dart';

class KeysNewScreenSaveRestore extends StatelessWidget {
  static const String _text = "Already have an account?";
  static final double _fontSize = 5.w;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveScreenService>(context);
    return TextButton(
        onPressed: () => service.controller.goToRestore(context),
        child: Text(_text,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
