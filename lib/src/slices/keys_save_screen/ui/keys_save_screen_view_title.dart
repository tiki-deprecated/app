/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysNewScreenViewTitle extends StatelessWidget {
  KeysNewScreenViewTitle();

  @override
  Widget build(BuildContext context) {
    return Text("Backup\nyour account",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConfigColor.tikiPurple,
            fontFamily: 'Koara',
            fontSize: 30.sp,
            fontWeight: FontWeight.bold));
  }
}
