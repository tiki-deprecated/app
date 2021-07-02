/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class KeysCreateScreenViewRestore extends StatelessWidget {
  static const String _text = "Already have an account?";
  static final double _fontSize = 17.sp;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysCreateScreenService>(context);
    return TextButton(
        onPressed: () => service.controller.goToRestore(context),
        child: Text(_text,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
