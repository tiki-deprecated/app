/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_color.dart';
import 'link_account_view_account.dart';
import 'link_account_view_see.dart';
import 'link_account_view_unlink.dart';

class LinkAccountViewLinked extends StatelessWidget {
  static const num _borderRadius = 4;

  final String type;
  final String icon;
  final String username;
  final Function()? onUnlink;
  final Function()? onSee;

  LinkAccountViewLinked(
      {required this.type,
      required this.icon,
      required this.username,
      this.onUnlink,
      this.onSee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onSee,
        behavior: HitTestBehavior.opaque,
        child: Container(
            decoration: BoxDecoration(
              color: ConfigColor.white,
              borderRadius: BorderRadius.circular(_borderRadius.w),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 2.w,
                  offset: Offset(0.75.w, 0.75.w), // Shadow position
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(_borderRadius.w),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: LinkAccountViewUnlink(onUnlink)),
                    Container(
                        padding: EdgeInsets.only(left: 3.w, top: 0.75.h),
                        child: LinkAccountViewAccount(
                            icon: icon, type: type, username: username)),
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      width: double.infinity,
                      color: ConfigColor.greyThree,
                      height: 1.sp,
                    ),
                    Container(child: LinkAccountViewSee(type))
                  ],
                ))));
  }
}
