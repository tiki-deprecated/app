/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_save_dialog_copy_service.dart';

class KeysSaveDialogCopyViewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveDialogCopyService>(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras),
        child: Container(
            width: 65.w,
            child: Text("CONTINUE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConfigColor.white,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w800,
                  fontSize: 16.sp,
                  letterSpacing: 0.05.w,
                ))),
        onPressed: service.model.isCopiedKey
            ? () => service.controller.continueAction(context)
            : null);
  }
}
