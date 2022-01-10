/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysRestoreScreenViewTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Enter your keys",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: ConfigColor.tikiPurple));
  }
}
