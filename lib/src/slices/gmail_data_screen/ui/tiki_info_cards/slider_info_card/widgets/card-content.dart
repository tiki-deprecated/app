import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'card-cta.dart';

class CardContent extends StatelessWidget {
  final BoxConstraints constraints;
  final AnimationController animation;

  final cardContentData;

  CardContent(this.constraints, this.animation,
      {required this.cardContentData});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ConfigColor.mardiGras,
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(
                  left: 2.9.h,
                  top: 1.9.h,
                  right: 1.9.h,
                  bottom: 1.9.h),
              child: this.cardContentData['cardContentData']
                  ['richTextExplanation']),
          _whatTheySay(),
          _youShouldKnow(),
          CardCta(cardCtaArgs: this.cardContentData['cardCtaData']),
        ]));
  }

  _whatTheySay() {
    List<Map> theySayData = this.cardContentData['cardContentData']['theysay'];
    List<Widget> theysay = [];
    for (int i = 0; i < theySayData.length; i++) {
      if (i > 0)
        theysay.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.white,
            )));
      theysay.add(Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 20),
            child: HelperImage(theySayData[i]['image'], width: 30)),
        Expanded(
          child: Text(theySayData[i]['text'],
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        )
      ]));
    }
    return Container(
        color: ConfigColor.tikiBlack,
        padding: EdgeInsets.all(25),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.only(bottom: 20),
              width: double.maxFinite,
              child: Text("What Google says it needs it for:",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "NunitoSans",
                      color: Colors.white,
                      fontWeight: FontWeight.w900))),
          ...theysay
        ]));
  }

  _youShouldKnow() {
    List<Map> youShouldKnowData =
        this.cardContentData['cardContentData']['youShouldKnow'];
    List<Widget> youShouldKnow = [];
    for (int i = 0; i < youShouldKnowData.length; i++) {
      if (i > 0)
        youShouldKnow.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.white,
            )));
      youShouldKnow.add(Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 20),
            child: HelperImage(youShouldKnowData[i]['image'], width: 30)),
        Expanded(
          child: Text(youShouldKnowData[i]['text'],
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
        )
      ]));
    }
    return Container(
        margin: EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: HelperImage(
            "information",
            width: 35,
          )),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text("You should know",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10), child: Container()),
          ...youShouldKnow
        ]));
  }
}
