/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'user_account_modal_view_community.dart';
import 'user_account_modal_view_follow_us.dart';
import 'user_account_modal_view_news.dart';
import 'user_account_modal_view_release.dart';
import 'user_account_modal_view_version.dart';

class UserAccountModalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 90.h,
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              UserAccountModalViewRelease(),
              UserAccountModalViewNews(),
              UserAccountModalViewCommunity(),
              UserAccountModalViewFollowUs(),
              UserAccountModalViewVersion()
            ]))));
  }
}
