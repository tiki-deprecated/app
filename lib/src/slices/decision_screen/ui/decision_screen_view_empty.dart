/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class DecisionScreenViewEmpty extends StatelessWidget {
  static const String _noMore = "No more data decisions.";
  static const String _party = "You can now go party!";
  static const num _fontSize = 15;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image(
        image: AssetImage('res/images/pineapple-floatie.png'),
        height: 7.5.h,
        fit: BoxFit.fitHeight,
      ),
      Padding(
          padding: EdgeInsets.only(top: 1.5.h),
          child: Text(_noMore,
              style: TextStyle(
                  fontFamily: ConfigFont.familyKoara,
                  fontSize: _fontSize.sp,
                  color: ConfigColor.blue,
                  fontWeight: FontWeight.bold))),
      Padding(
          padding: EdgeInsets.only(top: 0.3.h),
          child: Text(_party,
              style: TextStyle(
                  fontFamily: ConfigFont.familyKoara,
                  fontSize: _fontSize.sp,
                  color: ConfigColor.tikiBlue,
                  fontWeight: FontWeight.bold)))
    ]));
  }
}
