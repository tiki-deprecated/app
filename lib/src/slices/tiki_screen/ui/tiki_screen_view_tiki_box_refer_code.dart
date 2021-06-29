/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

class TikiScreenViewTikiBoxReferCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    var code = service.model.code;
    if (code.isEmpty) service.getCode(context);
    return OutlinedButton(
        onPressed: () async => service.controller.copyLink(context),
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: ConfigColor.alto),
            primary: ConfigColor.gray,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1.h)))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(service.presenter.textTikiBoxReferCode,
              style: TextStyle(
                  fontSize: service.presenter.fontSizeTikiBoxReferCode.sp,
                  fontWeight: FontWeight.bold,
                  color: ConfigColor.gray)),
          Container(
              margin: EdgeInsets.only(
                  left: 2.w, right: 4.w, top: 1.25.h, bottom: 1.25.h),
              child: Text(service.model.code,
                  style: TextStyle(
                      fontSize: service.presenter.fontSizeTikiBoxReferCode.sp,
                      fontWeight: FontWeight.bold,
                      color: ConfigColor.tikiBlue))),
          HelperImage("icon-copy"),
        ]));
  }
}
