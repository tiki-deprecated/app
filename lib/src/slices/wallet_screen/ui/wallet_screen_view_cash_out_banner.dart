/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class WalletScreenViewCashOutBanner extends StatelessWidget {
  static const String _text = "Coming soon";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage('res/images/banner.png'),
          height: 3.5.h,
          fit: BoxFit.cover,
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 4.w),
            child: Text(
              _text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: ConfigColor.tikiBlue),
            ))
      ],
    );
  }
}
