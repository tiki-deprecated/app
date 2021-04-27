/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

//(h/t) https://medium.com/flutter-community/flutter-effectively-scale-ui-according-to-different-screen-sizes-2cb7c115ea0a

import 'package:flutter/widgets.dart';

class PlatformRelativeSize {
  static MediaQueryData _mediaQueryData = new MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;

  static double blockHorizontal = 0;
  static double blockVertical = 0;

  static double marginHorizontal = 8 * blockHorizontal;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    double safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    double safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    blockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    blockVertical = (screenHeight - safeAreaVertical) / 100;
  }
}
