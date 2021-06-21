/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

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
            fontSize: fontSize * PlatformRelativeSize.blockHorizontal,
            fontWeight: FontWeight.bold));
  }
}
