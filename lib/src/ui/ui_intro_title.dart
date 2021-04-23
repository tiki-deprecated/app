/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class UiIntroTitle extends StatelessWidget {
  static final double _fontSize = 10 * PlatformRelativeSize.blockHorizontal;

  final String text;
  UiIntroTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: _fontSize,
            fontWeight: FontWeight.bold));
  }
}
