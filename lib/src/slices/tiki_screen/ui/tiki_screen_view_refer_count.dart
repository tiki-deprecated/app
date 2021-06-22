/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewReferCount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TikiScreenViewReferCount();
}

class _TikiScreenViewReferCount extends State<TikiScreenViewReferCount> {
  static const String _text = "people joined";
  static final double _fontSize = 4.w;
  static final double _marginRight = 2.w;


  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.only(right: _marginRight),
          child: HelperImage("ref-user")),
      Text("0" //count.toString() + " "
          + _text,
          style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
              color: ConfigColor.jade))
    ]);
  }
}
