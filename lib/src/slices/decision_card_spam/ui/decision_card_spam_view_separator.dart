import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewSeparator extends StatelessWidget {
  static const num _margin = 3;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: Container(
              margin: EdgeInsets.only(right: _margin.w),
              height: 1,
              color: ConfigColor.greyThree)),
      HelperImage("icon-email", height: 2.h),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(left: _margin.w),
              height: 1,
              color: ConfigColor.greyThree)),
    ]);
  }
}
