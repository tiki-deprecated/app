/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class KeysSaveDialogCopyViewTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Save securely to a pass manager",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConfigColor.mardiGras,
            fontFamily: 'Koara',
            fontSize: 28.sp,
            fontWeight: FontWeight.bold));
  }
}
