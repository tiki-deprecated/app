/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class ConfigShadow {
  static const Color contentColor = Color(0x0D000000);
  static const num contentBlurRadius = 20;
  static const num contentOffsetX = 9;
  static const num contentOffsetY = contentOffsetX;

  static BoxShadow content = BoxShadow(
    color: contentColor,
    blurRadius: SizeProvider.instance.size(contentBlurRadius),
    offset: Offset(SizeProvider.instance.size(contentOffsetX),
        SizeProvider.instance.size(contentOffsetY)),
  );
}
