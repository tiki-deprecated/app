/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer_code.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer_count.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_view_tiki_box_refer_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

class TikiScreenViewTikiBoxRefer extends StatelessWidget {
  static final double _marginTopCount = 1.h;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Column(children: [
      TikiScreenViewTikiBoxReferText(),
      Container(
          margin: EdgeInsets.only(
              top: service.presenter.marginTikiBoxReferCodeTop.h,
              left: service.presenter.marginTikiBoxReferCodeHorizontal.w,
              right: service.presenter.marginTikiBoxReferCodeHorizontal.w),
          child: TikiScreenViewTikiBoxReferCode()),
      Container(
          margin: EdgeInsets.only(
              top: service.presenter.marginTikiBoxReferCountTop.h),
          child: TikiScreenViewTikiBoxReferCount())
    ]);
  }
}
