/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenViewTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Enter your keys",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: ConfigColor.mardiGras));
  }
}
