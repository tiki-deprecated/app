/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenViewSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Upload, scan, or manually enter your TIKI account keys",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "NunitoSans",
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: ConfigColor.emperor));
  }
}
