/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysSaveDialogCopyViewFieldHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR ACCOUNT E-MAIL AND KEY',
      style: TextStyle(
          fontFamily: "NunitoSans",
          color: ConfigColor.greyFour,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp),
    );
  }
}
