/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../widgets/modal_divider.dart';
import '../model/security_score_modal_model.dart';
import '../security_score_modal_service.dart';
import 'security_score_modal_view_button.dart';
import 'security_score_modal_view_desc.dart';
import 'security_score_modal_view_explain.dart';
import 'security_score_modal_view_score.dart';

class SecurityScoreModalLayout extends StatelessWidget {
  static const String _title = 'Security score';

  @override
  Widget build(BuildContext context) {
    SecurityScoreModalModel model =
        Provider.of<SecurityScoreModalService>(context).model;
    return GestureDetector(
        child: SafeArea(
            child: Container(
                height: 85.h,
                margin: EdgeInsets.symmetric(horizontal: 7.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 2.5.h),
                          child: ModalDivider()),
                      Container(
                          margin: EdgeInsets.only(top: 5.h),
                          alignment: Alignment.center,
                          child: Text(
                            _title,
                            style: TextStyle(
                                color: ConfigColor.tikiBlue,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 3.h),
                          alignment: Alignment.topLeft,
                          child: SecurityScoreModalViewDesc(
                              noScore: model.security == null)),
                      Container(
                          margin: EdgeInsets.only(top: 3.h),
                          child: SecurityScoreModalViewScore(
                              security: model.security,
                              hacking: model.hacking,
                              sensitivity: model.sensitivity)),
                      Container(
                          margin: EdgeInsets.only(top: 3.h),
                          child: SecurityScoreModalViewExplain()),
                      Expanded(
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: SecurityScoreModalViewButton()))
                    ]))));
  }
}
