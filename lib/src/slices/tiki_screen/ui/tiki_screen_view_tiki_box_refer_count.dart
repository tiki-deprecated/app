/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTikiBoxReferCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.only(right: 2.w), child: HelperImage("ref-user")),
      Text(
          service.model.referCount.toString() +
              " " +
              service.presenter.textTikiBoxReferCount,
          style: TextStyle(
              fontSize: service.presenter.fontSizeTikiBoxReferCount.sp,
              fontWeight: FontWeight.w600,
              color: ConfigColor.jade))
    ]);
  }
}
