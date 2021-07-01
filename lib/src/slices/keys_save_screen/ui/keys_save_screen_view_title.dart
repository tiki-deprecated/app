/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysNewScreenViewTitle extends StatelessWidget {
  KeysNewScreenViewTitle();

  @override
  Widget build(BuildContext context) {
    return Text("Backup\nyour account",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConfigColor.mardiGras,
            fontFamily: 'Koara',
            fontSize: 30.sp,
            fontWeight: FontWeight.bold));
  }
}
