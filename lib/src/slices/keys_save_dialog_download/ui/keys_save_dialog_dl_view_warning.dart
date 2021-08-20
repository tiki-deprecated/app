/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysSaveDialogDlViewWarning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
        'Try not to store your keys on iCloud / Google Drive / Dropbox.',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConfigColor.greySeven,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600));
  }
}
