/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenTitle extends StatelessWidget {
  final String _text;
  static final double _fontSize = 10 * PlatformRelativeSize.blockHorizontal;

  HomeScreenTitle(this._text);

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
