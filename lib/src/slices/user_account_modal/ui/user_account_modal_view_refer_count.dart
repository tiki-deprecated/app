/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../user_account_modal_service.dart';

class UserAccountModalViewReferCount extends StatelessWidget {
  static const String _text = "people joined the TIKI tribe";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<UserAccountModalService>(context);
    service.controller.updateUserCount(context);
    return Column(children: [
      Text(
          service.model.signupCount?.toString().replaceAllMapped(
                  new RegExp(r'(\d{1,3})(?=(\d{3})+$)'), (m) => "${m[1]},") ??
              "...",
          style: TextStyle(
              color: ConfigColor.tikiPink,
              fontFamily: 'Koara',
              fontWeight: FontWeight.bold,
              height: 0,
              fontSize: 63.sp)),
      Text(_text,
          style: TextStyle(
              fontSize: 14.sp,
              height: 2.25,
              fontWeight: FontWeight.w800,
              color: ConfigColor.tikiBlue))
    ]);
  }
}
