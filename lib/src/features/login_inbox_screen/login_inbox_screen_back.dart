/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginInboxScreenBack extends StatelessWidget {
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;
  static final double _marginRightArrow =
      1 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Row(children: [
        Container(
          child: HelperImage('back-arrow'),
          margin: EdgeInsets.only(right: _marginRightArrow),
        ),
        Text(ConfigString.loginInbox.back,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.w800,
                fontSize: _fontSize))
      ]),
    );
  }
}
