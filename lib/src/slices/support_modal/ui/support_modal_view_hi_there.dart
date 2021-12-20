/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class SupportModalViewHiThere extends StatelessWidget {
  static const String _text = "Hi, there 👋";
  static const num _paddingVert = 2.5;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: _paddingVert.h,
        ),
        child: Text(_text,
            style: TextStyle(
                color: ConfigColor.tikiPurple,
                fontWeight: FontWeight.w800,
                fontSize: 12.sp)));
  }
}
