/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class TikiTitle extends StatelessWidget {
  final int fontSize;
  final String text;
  final TextAlign textAlign;

  const TikiTitle(this.text,
      {this.textAlign = TextAlign.center, this.fontSize = 10});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: this.textAlign,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: fontSize.sp,
            fontWeight: FontWeight.bold));
  }
}
