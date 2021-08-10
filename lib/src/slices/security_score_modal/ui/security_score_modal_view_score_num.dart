/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class SecurityScoreModalViewScoreNum extends StatelessWidget {
  final score;
  final text;

  const SecurityScoreModalViewScoreNum(this.score, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("${this.score} / 10",
          style: TextStyle(
              color: ConfigColor.tikiBlue,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold)),
      Text(this.text,
          style: TextStyle(
              color: ConfigColor.greyFive,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold))
    ]);
  }
}
