/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class LoginEmailScreenCta extends StatelessWidget {
  static const String _text = "Enter your email below to begin.";
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        style: TextStyle(
            color: ConfigColor.emperor,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600));
  }
}
