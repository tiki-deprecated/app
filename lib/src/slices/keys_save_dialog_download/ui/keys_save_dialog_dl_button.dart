/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_save_dialog_dl_service.dart';

class KeysSaveDialogDlViewButton extends StatelessWidget {
  final GlobalKey repaintKey;

  KeysSaveDialogDlViewButton({required this.repaintKey});

  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<KeysSaveDialogDlService>(context, listen: false).controller;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 15.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras),
        child: Text("DOWNLOAD",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ConfigColor.white,
              fontFamily: "NunitoSans",
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
              letterSpacing: 0.05.w,
            )),
        onPressed: () => controller.downloadQR(context, repaintKey));
  }
}
