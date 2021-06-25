/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTikiBoxCounter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TikiScreenViewTikiBoxCounter();
}

class _TikiScreenViewTikiBoxCounter
    extends State<TikiScreenViewTikiBoxCounter> {
  static final double _fontSizeCount = 20.sp;
  static final double _fontSizeText = 15.sp;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Column(children: [
      Text(
          service.model.count == 0
              ? "..."
              : service.model.count.toString().replaceAllMapped(
                  new RegExp(r'(\d{1,3})(?=(\d{3})+$)'), (m) => "${m[1]},"),
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
