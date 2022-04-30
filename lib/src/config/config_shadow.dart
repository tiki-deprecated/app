/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class ConfigShadow {
  static const Color contentColor = Color(0x0D000000);
  static const num contentBlurRadius = 2.67;
  static const num contentOffsetX = 1.06;
  static const num contentOffsetY = contentOffsetX;

  static BoxShadow content = BoxShadow(
    color: contentColor,
    blurRadius: SizeProvider.instance.contentBlurRadius,
    offset: Offset(contentOffsetX.w, contentOffsetY.w),
  );
}
