/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysCreateScreenViewTitle extends StatelessWidget {
  static const String _text = "Just one sec..";
  static final double _fontSize = 30.sp;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: _fontSize,
            fontWeight: FontWeight.bold));
  }
}
