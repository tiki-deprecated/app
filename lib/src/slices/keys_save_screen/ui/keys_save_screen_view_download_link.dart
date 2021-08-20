/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../keys_save_screen_service.dart';

class KeysSaveScreenViewDownloadLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<KeysSaveScreenService>(context).controller;
    return GestureDetector(
        onTap: () => controller.goToDownloadLocation(),
        child: RichText(
            text: TextSpan(
                text: "Saved to: ",
                style: TextStyle(
                    fontFamily: "NunitoSans",
                    fontSize: 11.sp,
                    color: ConfigColor.greySeven,
                    fontWeight: FontWeight.w600),
                children: [
              TextSpan(
                  text: _location(),
                  style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 11.sp,
                      decoration: TextDecoration.underline,
                      color: ConfigColor.blue,
                      fontWeight: FontWeight.w600))
            ])));
  }

  String _location() {
    if (Platform.isIOS)
      return "Files > On My iPhone > TIKI > tiki-do-not-share.png";
    else
      return "Files > Downloads > tiki-do-not-share.png";
  }
}
