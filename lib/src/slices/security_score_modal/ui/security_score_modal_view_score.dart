/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import 'security_score_modal_view_score_num.dart';

class SecurityScoreModalViewScore extends StatelessWidget {
  static const String _leadIn =
      'The security score is determined by two ratings:';
  static const String _labelSensitivity = 'SENSITIVITY';
  static const String _labelHacking = 'HACKING';
  final double? hacking;
  final double? sensitivity;
  final double? security;

  const SecurityScoreModalViewScore(
      {this.hacking, this.sensitivity, this.security});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(_leadIn,
          style: TextStyle(
              color: ConfigColor.tikiBlue,
              fontFamily: ConfigFont.familyNunitoSans,
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600)),
      if (security != null)
        Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SecurityScoreModalViewScoreNum(
                      score: this.sensitivity, label: _labelSensitivity),
                  Container(
                    width: 1,
                    height: 8.h,
                    color: ConfigColor.greyFour,
                  ),
                  SecurityScoreModalViewScoreNum(
                      score: this.hacking, label: _labelHacking),
                ])),
    ]);
  }
}
