/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class WalletScreenViewCashOutText extends StatelessWidget {
  static const String _text =
      "Sell your data & cash out your \nearnings to your bank account";

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
          color: ConfigColor.tikiBlue,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp),
    );
  }
}
