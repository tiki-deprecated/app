/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysSaveDialogCopyViewFieldHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR ACCOUNT E-MAIL AND KEY',
      style: TextStyle(
          fontFamily: "NunitoSans",
          color: ConfigColor.silverChalice,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp),
    );
  }
}
