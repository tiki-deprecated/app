/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenViewSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras,
            padding: EdgeInsets.symmetric(vertical: 2.h)),
        child: Container(
            width: 70.w,
            child: Text("SUBMIT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConfigColor.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.sp,
                  letterSpacing: 0.05.w,
                ))),
        onPressed: null);
  }
}
