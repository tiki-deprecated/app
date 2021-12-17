/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/support_screen/ui/support_screen_view_box_content.dart';
import 'package:app/src/slices/support_screen/ui/support_screen_view_hi_there.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'support_screen_view_breadcrumb.dart';
import 'support_screen_view_header.dart';

class SupportScreenLayout extends StatelessWidget {
  static const num _cardMarginTop = 2.25;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        child: Container(
            height: 85.h,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SupporScreenViewHeader(),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 6.w, right: 6.w, bottom: 5.h),
                          child:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                            SupportScreenViewHiThere(),
                            SupportScreenViewBreadcrumb(),
                            Container(
                                margin: EdgeInsets.only(top: 4.h),
                                child: SupportScreenViewBoxContent()),
                          ]))))
            ])));
  }
}
