/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysSaveDialogCopyViewSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "Copy and paste",
          style: TextStyle(
              fontFamily: "NunitoSans",
              color: ConfigColor.greySeven,
              fontSize: 12.sp,
              fontWeight: FontWeight.w800),
          children: [
            TextSpan(
                text:
                    " your security key into your preferred password manager for safe keeping.",
                style: TextStyle(
                    fontFamily: "NunitoSans",
                    color: ConfigColor.greySeven,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600))
          ]),
    );
  }
}
