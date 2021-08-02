import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewHeader extends StatelessWidget {
  final shareKey;
  final shareMessage;

  final service;

  DecisionCardSpamViewHeader(this.service, this.shareKey, this.shareMessage);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Row(children: [
        HelperImage("gmail-round-logo", width: 6.w),
        Padding(padding: EdgeInsets.only(right: 2.w)),
        Text(
          "Your Gmail Account",
          style: TextStyle(
              fontFamily: "NunitoSans",
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: ConfigColor.tikiBlue),
            )
          ])),
      GestureDetector(
          onTap: () =>
              service.controller.shareCard(context, shareKey, shareMessage),
          child: Padding(
              padding: EdgeInsets.only(right: 3.w),
              child:
              Icon(Icons.share, color: ConfigColor.orange, size: 6.w)))
    ]);
  }
}
