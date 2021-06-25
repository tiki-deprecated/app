/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTikiBoxReferCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO rollback
    var link = ""; //Provider.of<TikiScreenService>(context).model.link;
    var service = Provider.of<TikiScreenService>(context);
    return OutlinedButton(
        onPressed: () async {
          Clipboard.setData(new ClipboardData(text: link.toString()));
        },
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
              child: Text('FIXME', //TODO referral codes need to be fixed
                  style: TextStyle(
                      fontSize: service.presenter.fontSizeTikiBoxReferCode.sp,
                      fontWeight: FontWeight.bold,
                      color: ConfigColor.tikiBlue))),
          HelperImage("icon-copy"),
        ]));
  }
}
