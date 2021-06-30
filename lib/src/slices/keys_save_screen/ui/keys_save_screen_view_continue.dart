/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// The Continue button in save your keys screen.
///
/// Navigates to Home Screen after saving the keys.
class KeysNewScreenSaveContinue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 20.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras),
        child: Text("CONTINUE",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ConfigColor.white,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
              letterSpacing: 0.05.w,
            )),
        onPressed: true ? () => {} : null);
  }
}
