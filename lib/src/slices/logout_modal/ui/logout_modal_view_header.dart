/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/helper_image.dart';

class LogoutModalViewHeader extends StatelessWidget {
  static const num _paddingVert = 2.5;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: _paddingVert.h,
            bottom: _paddingVert.h,
          ),
          child: HelperImage('modal-top'))
    ]);
  }
}
