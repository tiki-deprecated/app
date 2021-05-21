/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenTitle extends StatelessWidget {
  static const String _text = "We\'re stronger together";
  static final double _fontSize = 10 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: _fontSize,
            fontWeight: FontWeight.bold));
  }
}
