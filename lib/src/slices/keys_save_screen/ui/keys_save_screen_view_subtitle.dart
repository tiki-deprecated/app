/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class KeysNewScreenViewSubtitle extends StatelessWidget {
  KeysNewScreenViewSubtitle();

  @override
  Widget build(BuildContext context) {
    return Text(
        "We recommend you to securely save your key in case you change your device.",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConfigColor.greySeven,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600));
  }
}
