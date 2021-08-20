/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';
import '../keys_save_screen_service.dart';

class KeysNewScreenSaveBk extends StatelessWidget {
  KeysNewScreenSaveBk();

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveScreenService>(context);
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: ConfigColor.greyThree),
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
                                      color: ConfigColor.tikiPurple)),
                              Text("(recommended)",
                                  style: TextStyle(
                                      fontSize: 3.h,
                                      fontWeight: FontWeight.bold,
                                      color: ConfigColor.green)),
                            ])
                      ])),
              service.model.saved
                  ? Positioned(
                      top: 0.25.h,
                      left: 6.w,
                      child: Container(
                          height: 5.h, child: HelperImage("green-check")))
                  : Container(),
            ])),
        onTap: () => service.controller.onBackup(context));
  }
}
