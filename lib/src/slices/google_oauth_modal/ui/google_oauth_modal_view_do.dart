/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';

class GoogleOauthModalViewDo extends StatelessWidget {
  static const String _text =
      'This adds a couple of extra steps to the process.\nIf it pops up, here’s what to do:';

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _text,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: ConfigColor.tikiBlue,
                fontSize: 11.5.sp,
                fontFamily: ConfigFont.familyNunitoSans,
                fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.5.h),
            child: Image.asset("res/images/gmail_alert.gif",
                height: 28.h, fit: BoxFit.fitHeight),
          )
        ]);
  }
}
