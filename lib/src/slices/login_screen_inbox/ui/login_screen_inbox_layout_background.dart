/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';

class LoginScreenInboxLayoutBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.cream)),
      Align(
          alignment: Alignment.topRight,
          child: HelperImage('login-email-blob-tr', height: 15.5.h)),
      Align(
          alignment: Alignment.bottomLeft,
          child: HelperImage('login-email-blob-bl', height: 21.h))
    ]);
  }
}
