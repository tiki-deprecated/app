/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysSaveDialogCopyViewTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Save securely to a pass manager",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConfigColor.tikiPurple,
            fontFamily: 'Koara',
            fontSize: 28.sp,
            fontWeight: FontWeight.bold));
  }
}
