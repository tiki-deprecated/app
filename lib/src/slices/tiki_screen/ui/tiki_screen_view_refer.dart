/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/home/home_screen/widgets/home_screen_refer_code.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_refer_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';

import 'home_screen_refer_count.dart';

class TikiScreenViewRefer extends StatelessWidget {
  static final double _marginTopCode = 1.h;
  static final double _marginTopCount = 1.h;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TikiScreenViewReferText(),
      Container(
          margin: EdgeInsets.only(top: _marginTopCode),
          child: TikiScreenViewReferCode()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCount),
          child: TikiScreenViewReferCount())
    ]);
  }
}
