/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/data_screen/ui/data_screen_view_score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'data_screen_view_soon.dart';

class DataScreenLayoutBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<DataScreenService>(context).model;
    return GestureDetector(
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    DataScreenViewScore(
                        image: model.isGmailLinked
                            ? "data-score-happy"
                            : "data-score-sad",
                        summary: model.isGmailLinked
                            ? "All good!"
                            : "Uh-oh. No data just yet!",
                        description: model.isGmailLinked
                            ? "Your account is linked now"
                            : "Get started by adding a Gmail account",
                        color: model.isGmailLinked
                            ? ConfigColor.jade
                            : ConfigColor.ikb),
                    Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: DataScreenViewSoon())
                  ],
                ))));
  }
}
