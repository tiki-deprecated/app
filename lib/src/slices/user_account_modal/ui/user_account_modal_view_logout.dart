/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/user_account_modal/user_account_modal_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserAccountModalViewLogout extends StatelessWidget {
  static const String _text = "Log out";

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<UserAccountModalService>(context).controller;
    return TextButton(
        onPressed: () => controller.onLogout(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_text,
                style: TextStyle(
                    color: ConfigColor.grenadier,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
            Container(
                margin: EdgeInsets.only(left: 3.w),
                child: HelperImage("icon-logout", height: 15.sp))
          ],
        ));
  }
}
