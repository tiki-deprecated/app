/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import 'md_viewer_view_back_button.dart';
import 'md_viewer_view_md.dart';

class MdViewerLayoutForeground extends StatelessWidget {
  static const num _marginTop = 2;
  static const num _marginBottom = 12;
  static const num _marginHorizontal = 6;
  static const num _marginBackLeft = 3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
      Container(
          margin: EdgeInsets.only(left: _marginBackLeft.w),
          child: MdViewerViewBackButton()),
      Container(
          margin: EdgeInsets.only(
              top: _marginTop.h,
              bottom: _marginBottom.h,
              left: _marginHorizontal.w,
              right: _marginHorizontal.w),
          child: MdViewerView()),
    ])));
  }
}
