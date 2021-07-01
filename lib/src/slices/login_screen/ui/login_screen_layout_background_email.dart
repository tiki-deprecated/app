/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreenBackgroundEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.serenade)),
      Container(
          margin: EdgeInsets.only(top: 2.h),
          alignment: Alignment.topRight,
          child: HelperImage('login-pineapple')),
      Container(
          margin: EdgeInsets.only(top: 32.h),
          alignment: Alignment.topLeft,
          child: HelperImage('login-blob'))
    ]);
  }
}
