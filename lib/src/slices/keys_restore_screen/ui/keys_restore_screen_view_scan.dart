/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/utils/helper_permission.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenViewScan extends StatelessWidget {
  static final double _marginHorizontal = 10.w;
  static final double _marginVertical = 2.5.h;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras,
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
                  child: HelperImage("icon-qr-code"))
            ])),
        onPressed: () async {
          if (await HelperPermission.request(Permission.camera)) {
            // BlocProvider.of<KeysRestoreScreenBloc>(context)
            //     .add(KeysRestoreScreenScanned());
          }
        });
  }
}
