/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../keys_save_screen_service.dart';

/// The Continue button in save your keys screen.
///
/// Navigates to Home Screen after saving the keys.
class KeysNewScreenSaveContinue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveScreenService>(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.tikiPurple),
        child: Container(
            width: 70.w,
            child: Text("CONTINUE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConfigColor.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.sp,
                  letterSpacing: 0.05.w,
                ))),
        onPressed:
            service.canContinue() ? () => service.controller.goToHome() : null);
  }
}
