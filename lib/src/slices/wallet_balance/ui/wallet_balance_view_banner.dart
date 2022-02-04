/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WalletBalanceViewBanner extends StatelessWidget {
  static const num _height = 10;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('res/images/ref-only-banner.png'),
      height: _height.h,
      fit: BoxFit.fitHeight,
    );
  }
}
