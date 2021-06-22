/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTitle extends StatelessWidget {
  final String _text;
  static final double _fontSize = 10.w;

  TikiScreenViewTitle(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: _fontSize,
            fontWeight: FontWeight.bold));
  }
}
