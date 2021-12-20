/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';
import '../user_account_modal_service.dart';

class UserAccountModalViewLogout extends StatelessWidget {
  static const String _text = "Log out";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<UserAccountModalService>(context);
    return TextButton(
        onPressed: () => service.controller.onLogout(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_text,
                style: TextStyle(
                    color: ConfigColor.tikiRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
            Container(
                margin: EdgeInsets.only(left: 3.w),
                child: HelperImage("icon-logout", height: 15.sp))
          ],
        ));
  }
}
