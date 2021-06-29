/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/auth/auth_service.dart';
import 'package:app/src/slices/keys_save_dialog/keys_new_screen_dialog_copy.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class KeysNewScreenSaveBk extends StatelessWidget {
  KeysNewScreenSaveBk();

  @override
  Widget build(BuildContext context) {
    var isSaved = false;
    var key = '';
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                  margin: EdgeInsets.only(bottom: 4.w),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: ConfigColor.alto),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: Offset(6, 6), // changes position of shadow
                        ),
                      ]),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 0.5.h, right: 4.w),
                            child: HelperImage("lock-icon")),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Save securely",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 3.h,
                                      color: ConfigColor.mardiGras)),
                              Text("(recommended)",
                                  style: TextStyle(
                                      fontSize: 3.h,
                                      fontWeight: FontWeight.bold,
                                      color: ConfigColor.jade)),
                            ])
                      ])),
              isSaved
                  ? Positioned(
                      top: 0.25.h,
                      left: 6.w,
                      child: Container(
                          height: 5.h, child: HelperImage("green-check")))
                  : Container(),
            ])),
        onTap: () => _saveKey(context));
  }

  _saveKey(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          var current = Provider.of<AuthService>(context).current;
          String key = "";
          return KeysNewScreenDialogCopy().alert(key, current);
        });
  }
}
