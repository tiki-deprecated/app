import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'decision_card_spam_view_opened.dart';
import 'decision_card_spam_view_sent.dart';

class DecisionCardSpamViewDataInfoRow extends StatelessWidget {
  static const num _width = 42;
  static const num _height = 14;
  final String? sinceYear;
  final int? totalEmails;
  final double? opened;

  const DecisionCardSpamViewDataInfoRow(
      this.sinceYear, this.totalEmails, this.opened);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: _width.w,
              child:
                  DecisionCardSpamViewSent(this.totalEmails, this.sinceYear)),
          Container(width: 1, height: _height.h, color: ConfigColor.greyTwo),
          Container(
              width: _width.w, child: DecisionCardSpamViewOpened(this.opened))
        ]);
  }
}
