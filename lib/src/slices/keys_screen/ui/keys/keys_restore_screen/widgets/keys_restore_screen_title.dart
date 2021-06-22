/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';

class KeysRestoreScreenTitle extends StatelessWidget {
  static const String _text = "Enter your keys";
  static final double _fontSize = 10.w;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: _fontSize,
            fontWeight: FontWeight.bold,
            color: ConfigColor.mardiGras));
  }
}
