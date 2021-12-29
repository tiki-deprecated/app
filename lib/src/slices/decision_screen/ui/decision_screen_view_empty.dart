/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../decision_screen_service.dart';
import '../model/decision_screen_model.dart';

class DecisionScreenViewEmpty extends StatelessWidget {
  static const String _noMore = "No more data decisions.\n";
  static const String _party = "You can now go party!";
  static const String _notNow =
      "we’re working on\ngetting your data in this space";
  static const String _justASec = "Just a sec, ";

  static const num _fontSize = 15;

  @override
  Widget build(BuildContext context) {
    DecisionScreenModel model =
        Provider.of<DecisionScreenService>(context).model;
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 12.5.h),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image(
            image: AssetImage('res/images/pineapple-floatie.png'),
            height: 13.h,
            fit: BoxFit.fitHeight,
          ),
          Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: model.isPending
                  ? RichText(
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
                        ]))
                  : RichText(
                      text: TextSpan(
                          text: _noMore,
                          style: TextStyle(
                              fontFamily: ConfigFont.familyKoara,
                              fontSize: _fontSize.sp,
                              color: ConfigColor.blue,
                              fontWeight: FontWeight.bold),
                          children: [
                          TextSpan(
                              text: _party,
                              style: TextStyle(
                                  fontFamily: ConfigFont.familyKoara,
                                  fontSize: _fontSize.sp,
                                  color: ConfigColor.tikiBlue,
                                  fontWeight: FontWeight.bold))
                        ])))
        ]));
  }
}
