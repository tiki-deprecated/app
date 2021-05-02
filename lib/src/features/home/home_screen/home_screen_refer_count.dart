/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenReferCount extends StatelessWidget {
  static const String _text = "people joined";
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;
  static final double _marginRight = 2 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.only(right: _marginRight),
          child: HelperImage("ref-user")),
      Text("0" + " " + _text,
          style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
              color: ConfigColor.jade))
    ]);
  }
}
