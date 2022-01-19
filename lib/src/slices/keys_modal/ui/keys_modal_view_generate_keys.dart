import '../../../config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class KeysModalViewGenerateKeys extends StatelessWidget {
  static const String _title = "Just one sec.";
  static const String _subtitle = "I am securing your account...";
  static final double _fontSize = 3.sp;
  static final double _marginTopTitle = 1.h;
  static final double _marginTopSubtitle = 2.h;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 100.w,
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            padding: EdgeInsets.only(top: _marginTopTitle),
            child: Text(_title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Koara',
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold))),
        Container(
            margin: EdgeInsets.only(top: _marginTopSubtitle),
            child: Text(_subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.w600,
                    color: ConfigColor.greySeven))),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: ClipRect(
                child: Align(
                    alignment: Alignment.center,
                    heightFactor: 0.5,
                    child: Lottie.asset(
                        "res/animation/Securing_account_with_blob.json")),
              ),
            ),
          ],
        ))
      ]));
  }
}
