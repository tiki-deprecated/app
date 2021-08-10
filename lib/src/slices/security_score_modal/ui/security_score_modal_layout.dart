/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../model/security_score_modal_model.dart';
import '../security_score_modal_service.dart';
import 'security_score_modal_view_empty.dart';
import 'security_score_modal_view_hack.dart';
import 'security_score_modal_view_score.dart';
import 'security_score_modal_view_sensitive.dart';

class SecurityScoreModalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SecurityScoreModalModel model =
        Provider.of<SecurityScoreModalService>(context).model;
    return GestureDetector(
        child: Container(
            height: 70.h,
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h),
                  ),
                  Divider(
                    height: 2.4.h,
                    thickness: 5,
                    color: ConfigColor.greyThree,
                    indent: 38.w,
                    endIndent: 38.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h * 1.5),
                  ),
                  Center(
                      child: Text(
                    'Security score',
                    style: TextStyle(
                        color: ConfigColor.tikiBlue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h * 1.5),
                  ),
                  model.sensitivity == null
                      ? SecurityScoreModalViewEmpty()
                      : Container(),
                  RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text:
                              'For each email list that emails you, we show\nyou a rating which we call a ',
                          style: TextStyle(
                            color: ConfigColor.tikiBlue,
                          ),
                          children: [
                            TextSpan(
                                text: 'Security score.',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ])),
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h),
                  ),
                  Text('The security score is determined by two ratings:'),
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h),
                  ),
                  model.sensitivity != null
                      ? SecurityScoreModalViewScore(
                          hacking: 69, sensitivity: 69)
                      : Container(),
                  SecurityScoreModalViewSensitive(),
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h),
                  ),
                  SecurityScoreModalViewHack(),
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h * 2),
                  ),
                  Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(90.w),
                      primary: ConfigColor.orange,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.w))),
                    ),
                    child: Text("OK, got it",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.of(context).pop(),
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 2.4.h * 3),
                  ),
                ])));
  }
}
