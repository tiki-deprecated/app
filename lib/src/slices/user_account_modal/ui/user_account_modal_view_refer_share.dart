/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../user_account_modal_service.dart';

class UserAccountModalViewReferShare extends StatelessWidget {
  static const String _text = "SHARE";

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<UserAccountModalService>(context).controller;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 1.25.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(right: 5.w),
                child: Text(_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                      letterSpacing: 0.05.w,
                    ))),
            Icon(
              Icons.share,
              size: 18.sp * 1.2,
            ),
          ],
        ),
        onPressed: () => controller.onShare(context));
  }
}
