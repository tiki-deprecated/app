import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../../../utils/helper_image.dart';
import '../decision_card_spam_service.dart';

class DecisionCardSpamViewHeader extends StatelessWidget {
  final GlobalKey shareKey;
  final String shareMessage;
  final DecisionCardSpamService service;

  DecisionCardSpamViewHeader(this.service, this.shareKey, this.shareMessage);

  @override
  Widget build(BuildContext context) {
    String provider = service.account?.provider;
    return Container(
        padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Row(children: [
            HelperImage("$provider-round-logo", width: 5.5.w),
            Padding(padding: EdgeInsets.only(right: 2.w)),
            Text(
              "Your $provider account",
              style: TextStyle(
                  fontFamily: ConfigFont.familyNunitoSans,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: ConfigColor.greySix),
            )
          ])),
          Opacity(
              opacity: 0,
              child: GestureDetector(
                  onTap: () => service.controller
                      .shareCard(context, shareKey, shareMessage),
                  child:
                  Icon(Icons.share, color: ConfigColor.orange, size: 8.w)))
        ]));
  }
}
