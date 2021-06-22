/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenBack extends StatelessWidget {
  static const String _text = "Back";
  static final double _fontSize = 5.w;
  static final double _marginRightArrow = 1.w;

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
        Text(_text,
            style: TextStyle(
                color: ConfigColor.orange,
                fontWeight: FontWeight.w800,
                fontSize: _fontSize))
      ]),
    );
  }
}
