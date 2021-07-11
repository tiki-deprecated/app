/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysSaveDialogDlViewTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Download key to your device",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConfigColor.tikiPurple,
            fontFamily: 'Koara',
            fontSize: 28.sp,
            fontWeight: FontWeight.bold));
  }
}
