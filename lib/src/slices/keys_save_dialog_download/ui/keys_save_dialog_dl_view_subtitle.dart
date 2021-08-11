/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysSaveDialogDlViewSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'We recommend storing your QR key ',
          style: TextStyle(
              fontFamily: "NunitoSans",
              color: ConfigColor.greySeven,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: 'off your phone',
              style: TextStyle(
                fontFamily: "NunitoSans",
                color: ConfigColor.greySeven,
                fontWeight: FontWeight.w800,
                fontSize: 12.sp,
              ),
            ),
            TextSpan(
              text: ', in case you lose it.',
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  color: ConfigColor.greySeven,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
            ),
          ]),
    );
  }
}
