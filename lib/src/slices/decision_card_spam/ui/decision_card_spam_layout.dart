import 'dart:math';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/decision_card_spam/decision_card_spam_service.dart';
import 'package:app/src/slices/decision_card_spam/model/decision_card_spam_model.dart';
import 'package:app/src/slices/decision_screen/model/decision_screen_model.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamLayout implements AbstractDecisionCardView {
  final DecisionCardSpamModel cardSpamModel;
  final DecisionCardSpamService service;

  DecisionCardSpamLayout(this.service, this.cardSpamModel);

  @override
  Future<void> callbackNo(BuildContext context) async {
    this
        .service
        .controller
        .unsubscribeFromSpam(context, this.cardSpamModel.senderId);
  }

  @override
  Future<void> callbackYes(BuildContext context) async {
    this.service.controller.keepReceiving(context, this.cardSpamModel.senderId);
  }

  @override
  Widget content(BuildContext context) {
    var shareKey = GlobalKey();
    return Container(
        key: shareKey,
        color: Colors.white,
        width: double.maxFinite,
        height: double.maxFinite,
        child: DecisionCardSpamLayoutContent(
            shareKey, this.service, this.cardSpamModel));
  }
}

class DecisionCardSpamLayoutContent extends StatelessWidget {
  final GlobalKey shareKey;

  final DecisionCardSpamModel cardSpamModel;
  final DecisionCardSpamService service;

  DecisionCardSpamLayoutContent(
      this.shareKey, this.service, this.cardSpamModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecisionCardSpamViewHeader(this.service, this.shareKey, "mensagem"),
        DecisionCardSpamViewCompany(
            logo: this.cardSpamModel.logoUrl,
            name: this.cardSpamModel.companyName,
            email: this.cardSpamModel.senderEmail),
        DecisionCardSpamViewFrequency(this.cardSpamModel.frequency.toString()),
        DecisionCardSpamViewSeparator(),
        DecisionCardSpamViewDataInfoRow(),
        DecisionCardSpamViewSecurity()
      ],
    );
  }
}

class DecisionCardSpamViewCompany extends StatelessWidget {
  final logo;
  final name;
  final email;

  const DecisionCardSpamViewCompany(
      {Key? key, this.logo, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getAvatar(this.logo, this.name, this.email),
        _getCompanyName(this.name, this.email)
      ],
    );
  }

  _getAvatar(logo, name, email) {
    if (logo != null) {
      return ClipOval(child: Image.network(logo, height: 8.h));
    } else {
      var img = 'avatar' + (Random().nextInt(2) + 1).toString();
      String title = name ?? email;
      return Stack(children: [
        HelperImage(img, height: 8.h),
        Text(title[0].toUpperCase())
      ]);
    }
  }

  _getCompanyName(name, email) {
    if (name != null) {
      return Text(name,
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "nunitoSans"));
    } else {
      return Text(email,
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "nunitoSans"));
    }
  }
}

class DecisionCardSpamViewFrequency extends StatelessWidget {
  final frequency;

  DecisionCardSpamViewFrequency(String this.frequency);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("They send you emails",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
        Text(frequency,
            style: TextStyle(
                fontFamily: "Koara",
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: _getTextColor(frequency))),
        _getCategory("Promotions")
      ],
    );
  }

  _getTextColor(String frequency) {
    switch (frequency) {
      case "monthly":
        return ConfigColor.green;
      case "daily":
        return ConfigColor.red;
      case "weekly":
        return ConfigColor.tikiOrange;
    }
  }

  _getCategory(category) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('in'),
          Padding(
            padding: EdgeInsets.only(left: 12.sp),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ConfigColor.greySix, width: 1.sp),
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
              child: Row(
                children: [
                  Icon(Icons.sell, color: ConfigColor.greySix),
                  Text(category, style: TextStyle(color: ConfigColor.greySix))
                ],
              ))
        ]);
  }
}

class DecisionCardSpamViewSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DecisionCardSpamViewSecurity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DecisionCardSpamViewDataInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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
        HelperImage("socialmedia1", width: 6.w),
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
          child: Icon(Icons.share, color: ConfigColor.orange, size: 36.sp))
    ]);
  }
}
