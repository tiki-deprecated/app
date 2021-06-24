import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/slices/tiki_screen/ui/tiki_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenPresenter{
  get marginVerticalShare => 6.h;
  get marginTopCards => 2.h;
  get marginVerticalLogOut => 4.h;

  final service;

  TikiScreenPresenter(this.service);

  get bgcolor => Color(0XFFF4F4F4);

  lockerWidth(context) => MediaQuery.of(context).size.width * 3 / 5;

  ChangeNotifierProvider<TikiScreenService> render() {
    return ChangeNotifierProvider.value(value: service, child: TikiScreenLayout());
  }
}



