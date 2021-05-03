/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class KeysRestoreScreenSubtitle extends StatelessWidget {
  static const String _text =
      "Upload, scan, or manually enter your TIKI account keys";
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            color: ConfigColor.emperor));
  }
}