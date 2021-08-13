/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/modal_divider.dart';
import 'google_oauth_modal_view_button.dart';
import 'google_oauth_modal_view_desc.dart';
import 'google_oauth_modal_view_do.dart';

class GoogleOauthModalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          margin: EdgeInsets.only(top: 4.5.h),
                          child: GoogleOauthModalViewDesc()),
                      Container(
                          margin: EdgeInsets.only(top: 1.h),
                          child: GoogleOauthModalViewDo()),
                      Expanded(
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: 1.h),
                              child: GoogleOauthModalViewButton()))
                    ]))));
  }
}
