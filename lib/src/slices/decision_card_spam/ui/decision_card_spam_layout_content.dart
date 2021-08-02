import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/decision_card_spam/decision_card_spam_service.dart';
import 'package:app/src/slices/decision_card_spam/model/decision_card_spam_model.dart';
import 'package:app/src/slices/decision_card_spam/ui/decision_card_spam_view_security.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'decision_card_spam_view_company.dart';
import 'decision_card_spam_view_data_info_row.dart';
import 'decision_card_spam_view_frequency.dart';
import 'decision_card_spam_view_header.dart';
import 'decision_card_spam_view_separator.dart';

class DecisionCardSpamLayoutContent extends StatelessWidget {
  final GlobalKey shareKey;

  final DecisionCardSpamModel cardSpamModel;
  final DecisionCardSpamService service;

  DecisionCardSpamLayoutContent(
      this.shareKey, this.service, this.cardSpamModel);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
          padding: EdgeInsets.all(3.w),
          child: DecisionCardSpamViewHeader(
              this.service, this.shareKey, "mensagem")),
      Padding(
          padding: EdgeInsets.all(3.w),
          child: DecisionCardSpamViewCompany(
              logo: this.cardSpamModel.logoUrl,
              name: this.cardSpamModel.companyName,
              email: this.cardSpamModel.senderEmail)),
      ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.sp)),
          child: Container(
              padding: EdgeInsets.all(4.w),
              color: ConfigColor.greyOne,
              child: Column(
                children: [
                  DecisionCardSpamViewFrequency(
                      this.cardSpamModel.frequency.toString(),
                      this.cardSpamModel.category.toString()),
                  DecisionCardSpamViewSeparator(),
                  DecisionCardSpamViewDataInfoRow(),
                  DecisionCardSpamViewSecurity()
                ],
              )))
    ]);
  }
}
