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

import '../keys_restore_screen_service.dart';

class KeysRestoreScreenViewScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<KeysRestoreScreenService>(context, listen: false)
            .controller;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.tikiPurple,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w)),
        child: Container(
            width: 70.w,
            child: Row(children: [
              Expanded(
                  child: Text("SCAN",
                      style: TextStyle(
                        color: ConfigColor.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                        letterSpacing: 0.05.w,
                      ))),
              Align(
                  alignment: Alignment.centerRight,
                  child: HelperImage("icon-qr-code", height: 16.sp))
            ])),
        onPressed: () => controller.scan());
  }
}
