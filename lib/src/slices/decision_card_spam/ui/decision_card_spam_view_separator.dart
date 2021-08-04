import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
        child: HelperImage("email-separator"));
  }
}
