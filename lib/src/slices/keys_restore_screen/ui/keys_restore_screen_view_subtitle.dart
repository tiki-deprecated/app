/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysRestoreScreenViewSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Upload, scan, or manually enter your TIKI account keys",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "NunitoSans",
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: ConfigColor.greySeven));
  }
}
