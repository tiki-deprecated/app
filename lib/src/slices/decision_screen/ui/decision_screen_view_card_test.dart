import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:app/src/slices/decision_screen/model/decision_screen_model.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../decision_screen_service.dart';

class DecisionScreenViewCardTest implements AbstractDecisionCardView {
  static const num _iconSize = 15;
  static const num _fontSizeTitle = 25;
  static const num _fontSizeText = 12.5;
  static const String _test = "Test card\n";
  static const String _testHow =
      "Test how the Unsubscribe feature works\nby swiping this card.\n";
  static const String _rememberThat = "Remember that, ";
  static const String _unsubscribe = "once you unsubscribe from\nan email, ";
  static const String _undo =
      "you can only undo your action by\ngoing to the email list’s website.";
  static const String _testCardBarText = 'TEST CARD #';

  final icons = [
    "test-card-watermelon",
    "test-card-pineapple",
    "test-card-lemon",
  ];

  var cardnum;

  DecisionScreenViewCardTest(this.cardnum);

  @override
  Future<void> callbackNo(BuildContext context) => _testDone(context);

  @override
  Future<void> callbackYes(BuildContext context) => _testDone(context);

  @override
  Widget content(BuildContext context) {
    return Container(
        color: ConfigColor.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  color: ConfigColor.green,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(2.h),
                  child: Center(
                      child: Text(_testCardBarText + (cardnum + 1).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: ConfigFont.familyNunitoSans,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp)))),
              Expanded(
                  child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                HelperImage(
                  icons[cardnum],
                  height: _iconSize.h,
                ),
                Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Text(
                      _test,
                      style: TextStyle(
                          color: ConfigColor.tikiBlue,
                          fontFamily: ConfigFont.familyKoara,
                          fontSize: _fontSizeTitle.sp,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  child: Text(
                    _testHow,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ConfigColor.tikiBlue,
                        fontFamily: ConfigFont.familyNunitoSans,
                        fontSize: _fontSizeText.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: _rememberThat,
                            style: TextStyle(
                                color: ConfigColor.tikiBlue,
                                fontFamily: ConfigFont.familyNunitoSans,
                                fontSize: _fontSizeText.sp,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: _unsubscribe,
                                style: TextStyle(
                                  color: ConfigColor.tikiBlue,
                                  fontFamily: ConfigFont.familyNunitoSans,
                                  fontSize: _fontSizeText.sp,
                                ),
                              ),
                              TextSpan(
                                  text: _undo,
                                  style: TextStyle(color: ConfigColor.orange)),
                            ]))),
              ])))
            ]));
  }

  Future<void> _testDone(context) async {
    if (cardnum + 1 == icons.length) {
      var service = Provider.of<DecisionScreenService>(context, listen: false);
      service.testDone();
    }
  }
}
