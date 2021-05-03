/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenReferText extends StatelessWidget {
  static const String _textLine1 = "Share your TIKI code and get";
  static const String _textLine2 = "\$5 for every 10 people who join.";
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _textLine1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
              color: ConfigColor.emperor),
        ),
        Text(
          _textLine2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.w800,
              color: ConfigColor.emperor),
        )
      ],
    );
  }
}
