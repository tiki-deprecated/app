/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/helper/helper_log_out.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenLogout extends StatelessWidget {
  static const String _text = "Log out";
  static final double _marginRight = 2 * PlatformRelativeSize.blockHorizontal;
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          HelperLogOut.provide(context).current(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.only(right: _marginRight),
              child: Text(_text,
                  style: TextStyle(
                      fontSize: _fontSize,
                      fontWeight: FontWeight.bold,
                      color: ConfigColor.grenadier))),
          HelperImage("icon-logout"),
        ]));
  }
}
