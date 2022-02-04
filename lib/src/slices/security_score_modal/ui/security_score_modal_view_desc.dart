/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';

class SecurityScoreModalViewDesc extends StatelessWidget {
  static const String _empty =
      'We’re sorry that we cannot provide you with a\nsecurity score for this email list right now.\nFind out more info about security score below.';
  static const String _text1 =
      'For each email list that emails you, we show you a rating which we call a ';
  static const String _text2 = 'Security score.';

  final bool noScore;

  const SecurityScoreModalViewDesc({this.noScore = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (noScore)
          Container(
              margin: EdgeInsets.only(bottom: 3.h),
              child: Text(_empty,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ConfigColor.tikiRed,
                      fontFamily: ConfigFont.familyNunitoSans,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600))),
        RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
                text: _text1,
                style: TextStyle(
                    color: ConfigColor.tikiBlue,
                    fontFamily: ConfigFont.familyNunitoSans,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                      text: _text2,
                      style: TextStyle(
                          color: ConfigColor.tikiBlue,
                          fontFamily: ConfigFont.familyNunitoSans,
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w800))
                ])),
      ],
    );
  }
}
