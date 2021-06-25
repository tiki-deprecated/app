import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TikiScreenPresenter {
  get marginTopCards => 2;
  get marginVerticalLogOut => 4;

  num get marginHorizontal => 6;
  num get marginGsTop => 14;
  num get marginEmailTop => 2;
  num get marginUpdatesTop => 3;
  num get marginTikiBoxTop => 2;

  num get marginTikiBoxCounterTop => 3;
  num get marginTikiBoxReferTop => 4;
  num get marginTikiBoxReferCodeTop => 1.5;
  num get marginTikiBoxReferCodeHorizontal => 11;
  num get marginTikiBoxReferCountTop => 1;
  num get marginTikiBoxShareTop => 4;
  num get marginTikiBoxShareBottom => 5;

  num get fontSizeHeading => 30;
  num get fontSizeTikiBoxCounterNum => 70;
  num get fontSizeTikiBoxCounterText => 14;
  num get fontSizeTikiBoxReferText => 14;
  num get fontSizeTikiBoxReferCode => 14;
  num get fontSizeTikiBoxReferShare => 18;
  num get fontSizeTikiBoxReferCount => 13;

  get textGs => "Get started";
  get textUpdates => "TIKI updates";
  get textTikiBoxCounter => "people joined the TIKI tribe";
  get textTikiBoxReferL1 => "Share your TIKI code and get";
  get textTikiBoxReferL2 => "\$5 for every 10 people who join.";
  get textTikiBoxReferCode => "YOUR CODE:";
  get textTikiBoxReferShare => "SHARE";
  get textTikiBoxReferCount => "people joined";

  get textTikiBoxReferShareMessage => "It's your data. Get paid for it.";

  final service;

  TikiScreenPresenter(this.service);

  get bgcolor => Color(0XFFF4F4F4);

  num get emailButtonMarginBottom => 2;

  num get emailButtonFont => 10;

  lockerWidth(context) => MediaQuery.of(context).size.width * 3 / 5;

  ChangeNotifierProvider<TikiScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: TikiScreenLayout());
  }
}
