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
import '../login_screen_inbox_service.dart';

class LoginScreenInboxBackButton extends StatelessWidget {
  static const num _fontSize = 15;
  static const String _text = "Back";

  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<LoginScreenInboxService>(context, listen: false).controller;
    return TextButton(
      onPressed: () => controller.back(),
      child: Row(children: [
        Container(
          child: HelperImage('back-arrow', height: _fontSize.sp),
          margin: EdgeInsets.only(right: 1.w),
        ),
        Text(_text,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.w800,
                fontSize: _fontSize.sp))
      ]),
    );
  }
}
