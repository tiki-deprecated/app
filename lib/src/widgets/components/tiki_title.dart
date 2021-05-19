/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class TikiTitle extends StatelessWidget {
  static final double _fontSize = 10 * PlatformRelativeSize.blockHorizontal;
  final String text;
  final TextAlign textAlign;

  TikiTitle(this.text, {this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: this.textAlign,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: _fontSize,
            fontWeight: FontWeight.bold));
  }
}
