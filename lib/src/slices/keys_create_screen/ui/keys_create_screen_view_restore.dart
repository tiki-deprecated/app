/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../keys_create_screen_service.dart';

class KeysCreateScreenViewRestore extends StatelessWidget {
  static const String _text = "Already have an account?";
  static final double _fontSize = 17.sp;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<KeysCreateScreenService>(context).controller;
    return TextButton(
        onPressed: () => controller.goToRestore(context),
        child: Text(_text,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
