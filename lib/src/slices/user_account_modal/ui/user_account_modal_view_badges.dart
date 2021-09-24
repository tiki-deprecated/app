/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import 'user_account_modal_view_badges_select.dart';

class UserAccountModalViewBadges extends StatelessWidget {
  static const String _soon = "COMING SOON";
  static const String _text =
      "Make more choices to win badges. \nChoose a badge to be your avatar.";
  static const String _badgeBeta = "Beta \ntester";
  static const String _badgeSoon = "Coming \nsoon";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ConfigColor.greyTwo, borderRadius: BorderRadius.circular(24)),
      padding: EdgeInsets.only(top: 3.h, left: 6.w, right: 6.w, bottom: 3.h),
      child: Column(
        children: [
          Text(
            _soon,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: ConfigColor.tikiBlue,
                fontSize: 14.sp),
          ),
          Padding(
              padding: EdgeInsets.only(top: 1.25.h),
              child: Text(_text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ConfigColor.tikiBlue,
                      fontSize: 11.sp))),
          Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserAccountModalViewBadgesSelect(
                        image: "badge-beta",
                        label: _badgeBeta,
                        isSelected: true),
                    UserAccountModalViewBadgesSelect(
                        image: "badge-alt-1",
                        label: _badgeSoon,
                        isSelected: false),
                    UserAccountModalViewBadgesSelect(
                        image: "badge-alt-2",
                        label: _badgeSoon,
                        isSelected: false),
                    UserAccountModalViewBadgesSelect(
                        image: "badge-alt-3",
                        label: _badgeSoon,
                        isSelected: false),
                  ])),
          Padding(
              padding: EdgeInsets.only(top: 1.25.h),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserAccountModalViewBadgesSelect(
                      image: "badge-alt-4",
                      label: _badgeSoon,
                      isSelected: false),
                  UserAccountModalViewBadgesSelect(
                      image: "badge-alt-5",
                      label: _badgeSoon,
                      isSelected: false),
                  UserAccountModalViewBadgesSelect(
                      image: "badge-alt-6",
                      label: _badgeSoon,
                      isSelected: false),
                  UserAccountModalViewBadgesSelect(
                      image: "badge-alt-7",
                      label: _badgeSoon,
                      isSelected: false),
                ],
              ))
        ],
      ),
    );
  }
}
