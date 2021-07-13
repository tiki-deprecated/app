/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class KeysCreateScreenViewSubtitle extends StatelessWidget {
  static const String _text = "I'm securing your account";
  static final double _fontSize = 17.sp;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            color: ConfigColor.greySix));
  }
}
