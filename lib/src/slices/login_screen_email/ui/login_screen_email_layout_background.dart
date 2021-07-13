/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreenEmailLayoutBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.cream)),
      Container(
          margin: EdgeInsets.only(top: 2.h),
          alignment: Alignment.topRight,
          child: HelperImage('login-pineapple', height: 24.h)),
      Container(
          margin: EdgeInsets.only(top: 32.h),
          alignment: Alignment.topLeft,
          child: HelperImage('login-blob', height: 11.5.h))
    ]);
  }
}
