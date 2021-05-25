/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TikiSubtitle extends StatelessWidget {
  final double? fontSize;
  final String text;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  TikiSubtitle(this.text,
      {this.fontWeight = FontWeight.bold,
      this.fontSize,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize ?? 5 * PlatformRelativeSize.blockHorizontal,
            fontWeight: fontWeight));
  }
}
