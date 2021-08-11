/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../config/config_font.dart';
import '../../../utils/helper_image.dart';
import '../google_oauth_modal_controller.dart';
import '../google_oauth_modal_service.dart';

class GoogleOauthModalViewDesc extends StatelessWidget {
  static const String _title = 'Just so you know...';
  static const String _text1 =
      'We’re patiently waiting for Google to put their stamp of approval on the TIKI app (a common practice called ';
  static const String _linkText = 'OAuth API verification';
  static const String _linkHref =
      'https://support.google.com/cloud/answer/7454865?hl=en';
  static const String _text2 = ').';

  @override
  Widget build(BuildContext context) {
    GoogleOauthModalController controller =
        Provider.of<GoogleOauthModalService>(context, listen: false).controller;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ConfigColor.tikiBlue,
                fontSize: 15.sp,
                fontFamily: ConfigFont.familyNunitoSans,
                fontWeight: FontWeight.w800),
          ),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: HelperImage('gmail_alert', height: 13.h)),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text: _text1,
                      style: TextStyle(
                          color: ConfigColor.tikiBlue,
                          fontFamily: ConfigFont.familyNunitoSans,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.5.sp),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () async => controller.openLink(_linkHref),
                            text: _linkText,
                            style: TextStyle(
                                color: ConfigColor.orange,
                                fontFamily: ConfigFont.familyNunitoSans,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.5.sp)),
                        TextSpan(
                            text: _text2,
                            style: TextStyle(
                                color: ConfigColor.tikiBlue,
                                fontFamily: ConfigFont.familyNunitoSans,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.5.sp)),
                      ])))
        ]);
  }
}
