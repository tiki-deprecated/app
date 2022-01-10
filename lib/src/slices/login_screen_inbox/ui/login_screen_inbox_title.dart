/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreenInboxTitle extends StatelessWidget {
  static const String _text = "Great, now check your inbox";

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        style: TextStyle(
            fontFamily: 'Koara', fontSize: 28.sp, fontWeight: FontWeight.bold));
  }
}
