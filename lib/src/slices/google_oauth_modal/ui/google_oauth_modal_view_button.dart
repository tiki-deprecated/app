/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../google_oauth_modal_controller.dart';
import '../google_oauth_modal_service.dart';

class GoogleOauthModalViewButton extends StatelessWidget {
  static const String _text = 'OK, got it';

  @override
  Widget build(BuildContext context) {
    GoogleOauthModalController controller =
        Provider.of<GoogleOauthModalService>(context, listen: false).controller;
    return TextButton(
      style: TextButton.styleFrom(
        primary: ConfigColor.white,
        backgroundColor: ConfigColor.orange,
        padding: EdgeInsets.symmetric(vertical: 1.75.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.w))),
      ),
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 26.sp,
          child: Text(_text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: ConfigFont.familyNunitoSans))),
      onPressed: () async => controller.onOk(context),
    );
  }
}
