/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../security_score_modal_controller.dart';
import '../security_score_modal_service.dart';

class SecurityScoreModalViewExplain extends StatelessWidget {
  static const String _textHacking =
      'A rating based on known recent security breaches/hacks (from ';
  static const String _textSensitivity =
      'A rating based on the sensitivity of the business emailing you, for example whether they are holding medical or financial information vs a clothing company. We find this information at ';
  static const String _labelSensitivity = 'SENSITIVITY SCORE';
  static const String _labelHacking = 'HACKING SCORE';
  static const String _linkSensitivity = 'bigpicture.io';
  static const String _linkHacking = 'haveibeenpwned.com';

  @override
  Widget build(BuildContext context) {
    SecurityScoreModalController controller =
        Provider.of<SecurityScoreModalService>(context, listen: false)
            .controller;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _label(_labelSensitivity),
      Container(
          margin: EdgeInsets.only(top: 0.5.h),
          child: _text(
              controller: controller,
              text: _textSensitivity,
              link: _linkSensitivity,
              close: '.')),
      Container(
          margin: EdgeInsets.only(top: 2.h), child: _label(_labelHacking)),
      Container(
          margin: EdgeInsets.only(top: 0.5.h),
          child: _text(
              controller: controller,
              text: _textHacking,
              link: _linkHacking,
              close: ')')),
    ]);
  }

  Widget _label(String label) {
    return Container(
        child: Text(label,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: ConfigColor.greySix, fontWeight: FontWeight.bold)));
  }

  Widget _text(
      {required String text,
      required String link,
      required String close,
      required SecurityScoreModalController controller}) {
    return Container(
        child: RichText(
            text: TextSpan(
                text: text,
                style: TextStyle(
                    color: ConfigColor.tikiBlue,
                    fontFamily: ConfigFont.familyNunitoSans,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600),
                children: [
          TextSpan(
              text: link,
              recognizer: TapGestureRecognizer()
                ..onTap = () async => controller.openLink('https://' + link),
              style: TextStyle(
                  color: ConfigColor.orange,
                  fontFamily: ConfigFont.familyNunitoSans,
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600)),
          TextSpan(
              text: close,
              style: TextStyle(
                  color: ConfigColor.tikiBlue,
                  fontFamily: ConfigFont.familyNunitoSans,
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600))
        ])));
  }
}
