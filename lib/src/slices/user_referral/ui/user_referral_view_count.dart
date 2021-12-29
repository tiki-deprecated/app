/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';
import '../user_referral_service.dart';

class UserReferralViewCount extends StatelessWidget {
  static const num _fontSize = 13;
  static const String _text = " people joined";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<UserReferralService>(context);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.only(right: 2.w),
          child: HelperImage("ref-user", height: _fontSize.sp)),
      Text(service.model.referCount.toString() + _text,
          style: TextStyle(
              fontSize: _fontSize.sp,
              fontWeight: FontWeight.w600,
              color: ConfigColor.green))
    ]);
  }
}
