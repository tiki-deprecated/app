/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';
import '../keys_save_screen_service.dart';

class KeysNewScreenSaveBkDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<KeysSaveScreenService>(context);
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                      color: ConfigColor.greyTwo,
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
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: HelperImage("icon-download")),
                        Text("Download",
                            style: TextStyle(
                                fontSize: 2.5.h,
                                fontWeight: FontWeight.bold,
                                color: ConfigColor.tikiPurple)),
                      ])),
              service.model.downloaded
                  ? Positioned(
                      top: 0,
                      left: 5.w,
                      child: Container(
                          height: 5.h, child: HelperImage("green-check")))
                  : Container(),
            ])),
        onTap: () => service.controller.onDownload(context, new GlobalKey()));
  }
}
