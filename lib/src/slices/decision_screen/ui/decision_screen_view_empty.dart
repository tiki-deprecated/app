/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class DecisionScreenViewEmpty extends StatelessWidget {
  static const String _noMore = "No more data decisions.";
  static const String _party = "You can now go party!";
  static const String _notNow =
      "we’re working on\ngetting your data in this space";
  static const String _justASec = "Just a sec, ";

  static const num _fontSize = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 12.5.h),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image(
            image: AssetImage('res/images/pineapple-floatie.png'),
            height: 15.h,
            fit: BoxFit.fitHeight,
          ),
          false
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    ],
                  )
                ])
              : Padding(
                  padding: EdgeInsets.only(top: 1.2.h),
                  child: RichText(
                      text: TextSpan(
                          text: _justASec,
                          style: TextStyle(
                              fontFamily: ConfigFont.familyKoara,
                              fontSize: _fontSize.sp,
                              color: ConfigColor.blue,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: _notNow,
                            style: TextStyle(
                                fontFamily: ConfigFont.familyKoara,
                                fontSize: _fontSize.sp,
                                color: ConfigColor.tikiBlue,
                                fontWeight: FontWeight.bold))
                      ])))
        ]));
  }
}
