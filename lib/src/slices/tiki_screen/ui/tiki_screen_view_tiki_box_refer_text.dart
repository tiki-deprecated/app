/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

class TikiScreenViewTikiBoxReferText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Column(
      children: [
        Text(
          service.presenter.textTikiBoxReferL1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: service.presenter.fontSizeTikiBoxReferText.sp,
              fontWeight: FontWeight.w600,
              color: ConfigColor.emperor),
        ),
        Text(
          service.presenter.textTikiBoxReferL2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: service.presenter.fontSizeTikiBoxReferText.sp,
              fontWeight: FontWeight.w800,
              color: ConfigColor.emperor),
        )
      ],
    );
  }
}
