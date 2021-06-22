/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewCounter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TikiScreenViewCounter();
}

class _TikiScreenViewCounter extends State<TikiScreenViewCounter> {
  static final double _fontSizeCount = 20.w;
  static final double _fontSizeText = 5.w;

  @override
  Widget build(BuildContext context) {
    var state = '';
    return Column(children: [
      Text("...",
          // true //(state.count == null || state.count == 0)
          //     ? "..."
          //     : state.count.toString().replaceAllMapped(
          //         new RegExp(r'(\d{1,3})(?=(\d{3})+$)'), (m) => "${m[1]},"),
          style: TextStyle(
              color: ConfigColor.flirt,
              fontFamily: 'Koara',
              fontWeight: FontWeight.bold,
              fontSize: _fontSizeCount)),
      Text("people already use TIKI",
          style: TextStyle(
              height: 1,
              fontSize: _fontSizeText,
              fontWeight: FontWeight.w800,
              color: ConfigColor.tikiBlue))
    ]);
  }
}
