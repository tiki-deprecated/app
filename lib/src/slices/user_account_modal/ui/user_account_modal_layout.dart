/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../user_account_modal_service.dart';
import 'user_account_modal_view_badges.dart';
import 'user_account_modal_view_community.dart';
import 'user_account_modal_view_follow_us.dart';
import 'user_account_modal_view_header.dart';
import 'user_account_modal_view_logout.dart';
import 'user_account_modal_view_news.dart';
import 'user_account_modal_view_profile.dart';
import 'user_account_modal_view_refer.dart';
import 'user_account_modal_view_release.dart';
import 'user_account_modal_view_version.dart';

class UserAccountModalLayout extends StatelessWidget {
  static const num _cardMarginTop = 2.25;

  @override
  Widget build(BuildContext context) {
    UserAccountModalService service = Provider.of<UserAccountModalService>(context);
    bool logoutModal = service.model.logoutModalActive;
    return Container(
      height: 85.h,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        UserAccountModalViewHeader(),
        Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 6.w, right: 6.w, bottom: 5.h),
                    child:
                        Column(mainAxisSize: MainAxisSize.min, children: [
                      UserAccountModalViewProfile(),
                      Container(
                          margin: EdgeInsets.only(top: 4.h),
                          child: UserAccountModalViewRefer()),
                      Container(
                          margin: EdgeInsets.only(top: _cardMarginTop.h),
                          child: UserAccountModalViewRelease()),
                      Container(
                          margin: EdgeInsets.only(top: _cardMarginTop.h),
                          child: UserAccountModalViewNews()),
                      Container(
                          margin: EdgeInsets.only(top: _cardMarginTop.h),
                          child: UserAccountModalViewCommunity()),
                      Container(
                          margin: EdgeInsets.only(top: _cardMarginTop.h),
                          child: UserAccountModalViewFollowUs()),
                      Container(
                          margin: EdgeInsets.only(top: _cardMarginTop.h),
                          child: UserAccountModalViewBadges()),
                      Container(
                          margin: EdgeInsets.only(top: 1.5.h),
                          child: UserAccountModalViewVersion()),
                      Container(
                          margin: EdgeInsets.only(top: 3.h),
                          child: UserAccountModalViewLogout()),
                    ]))))
      ]));
  }
}
