/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class LoginInboxScreenTitle extends StatelessWidget {
  static const String _text = "Great, now check your inbox";
  static final double _fontSize = 9.w;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: _fontSize,
            fontWeight: FontWeight.bold));
  }
}
