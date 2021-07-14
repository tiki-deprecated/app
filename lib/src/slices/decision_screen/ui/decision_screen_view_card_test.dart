import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../decision_screen_service.dart';

class DecisionScreenViewCardTest extends StatelessWidget {
  static const num _iconSize = 18;
  static const num _fontSizeTitle = 25;
  static const num _fontSizeText = 12.5;
  static const String _hey = "Hey, this is just a";
  static const String _test = "\ntest card";
  static const String _feature = "working on a feature ";
  static const String _featurePrefix = "We're ";
  static const String _unsubscribe =
      "\n(unsubscribe from emails) to fill this space.";
  static const String _meantime =
      "In the meantime, why don’t you swipe\n around, and tell us how this feels?";
  static const String _url =
      "https://www.notion.so/mytiki/206e9e86c520468ea604e057c0f0dea7?v=20062bf2771d4952840f862334a6cfc5";

  final String icon;

  DecisionScreenViewCardTest(this.icon);

  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<DecisionScreenService>(context, listen: false).controller;
    return Container(
        color: ConfigColor.white,
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image(
            image: AssetImage('res/images/' + icon + '.png'),
            height: _iconSize.h,
            fit: BoxFit.fitHeight,
          ),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: _hey,
                      style: TextStyle(
                          color: ConfigColor.tikiBlue,
                          fontFamily: ConfigFont.familyKoara,
                          fontSize: _fontSizeTitle.sp,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: _test,
                            style: TextStyle(color: ConfigColor.orange))
                      ]))),
          GestureDetector(
              onTap: () => controller.openLink(_url),
              child: Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: _featurePrefix,
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontFamily: ConfigFont.familyNunitoSans,
                              fontSize: _fontSizeText.sp,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: _feature,
                                style: TextStyle(color: ConfigColor.orange)),
                            TextSpan(text: _unsubscribe)
                          ])))),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: Text(
                _meantime,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ConfigColor.tikiBlue,
                    fontFamily: ConfigFont.familyNunitoSans,
                    fontSize: _fontSizeText.sp,
                    fontWeight: FontWeight.w600),
              ))
        ])));
  }
}
