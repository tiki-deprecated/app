/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTikiBoxCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Column(children: [
      Text(
          service.model.count == 0
              ? "..."
              : service.model.count.toString().replaceAllMapped(
                  new RegExp(r'(\d{1,3})(?=(\d{3})+$)'), (m) => "${m[1]},"),
          style: TextStyle(
              color: ConfigColor.flirt,
              fontFamily: 'Koara',
              fontWeight: FontWeight.bold,
              fontSize: service.presenter.fontSizeTikiBoxCounterNum.sp)),
      Text(service.presenter.textTikiBoxCounter,
          style: TextStyle(
              fontSize: service.presenter.fontSizeTikiBoxCounterText.sp,
              fontWeight: FontWeight.w800,
              color: ConfigColor.tikiBlue))
    ]);
  }
}
