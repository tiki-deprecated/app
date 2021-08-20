/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';

class SecurityScoreModalViewScoreNum extends StatelessWidget {
  final int? score;
  final String label;

  SecurityScoreModalViewScoreNum({double? score, required this.label})
      : this.score = score != null ? ((1 - score) * 10).floor() : null;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      score != null
          ? Text("${this.score} / 10",
              style: TextStyle(
                  color: _getColor(this.score!),
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold))
          : Text("? / 10",
              style: TextStyle(
                  color: ConfigColor.greyFour,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold)),
      Text(this.label,
          style: TextStyle(
              color: ConfigColor.greySix,
              fontSize: 11.5.sp,
              fontFamily: ConfigFont.familyNunitoSans,
              fontWeight: FontWeight.bold))
    ]);
  }

  Color _getColor(int score) {
    if (score < 4)
      return ConfigColor.tikiRed;
    else if (score < 7)
      return ConfigColor.tikiOrange;
    else
      return ConfigColor.green;
  }
}
