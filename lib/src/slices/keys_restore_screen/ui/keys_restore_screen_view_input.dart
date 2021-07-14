/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../keys_restore_screen_service.dart';

class KeysRestoreScreenViewInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<KeysRestoreScreenService>(context, listen: false)
            .controller;
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
      cursorColor: ConfigColor.orange,
      autocorrect: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          hintText: "Your Account Key",
          hintStyle: TextStyle(
              color: ConfigColor.greyFive,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ConfigColor.greyFive,
                  width: 1,
                  style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ConfigColor.greyFive,
                  width: 1,
                  style: BorderStyle.solid))),
      onChanged: (String s) => controller.updateKeys(s),
    );
  }
}
