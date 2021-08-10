/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/security_score_modal/ui/security_score_modal_view_score_num.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class SecurityScoreModalViewScore extends StatelessWidget {
  final int? hacking;
  final int? sensitivity;

  const SecurityScoreModalViewScore({this.hacking, this.sensitivity});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(children: [
        Center(child: HelperImage("vertical-separator", height: 8.h)),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecurityScoreModalViewScoreNum(this.sensitivity, 'SENSITIVITY'),
              SecurityScoreModalViewScoreNum(this.hacking, 'HACKING'),
            ])
      ]),
      Padding(
        padding: EdgeInsets.only(top: 2.4.h),
      ),
    ]);
  }
}
