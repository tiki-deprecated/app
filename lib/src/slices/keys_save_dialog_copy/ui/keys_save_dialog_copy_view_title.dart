/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class KeysSaveDialogCopyTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Password manager",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Koara', fontSize: 28.sp, fontWeight: FontWeight.bold));
  }
}
