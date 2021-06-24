/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer_code.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer_count.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTikiBoxRefer extends StatelessWidget {
  static final double _marginTopCode = 1.h;
  static final double _marginTopCount = 1.h;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TikiScreenViewTikiBoxReferText(),
      Container(
          margin: EdgeInsets.only(top: _marginTopCode),
          child: TikiScreenViewTikiBoxReferCode()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCount),
          child: TikiScreenViewTikiBoxReferCount())
    ]);
  }
}
