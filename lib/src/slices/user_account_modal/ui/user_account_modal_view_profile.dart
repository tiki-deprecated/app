/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import 'user_account_modal_view_profile_avatar.dart';

class UserAccountModalViewProfile extends StatelessWidget {
  static const String _avatarImage = "badge-beta-avatar";
  static const String _avatarLabel = "BETA TESTER";
  static const String _member = "TIKI tribe member";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserAccountModalViewProfileAvatar(
          avatar: _avatarImage,
          label: _avatarLabel,
        ),
        Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              _member,
              style: TextStyle(
                  color: ConfigColor.tikiBlue,
                  fontFamily: "Koara",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ))
      ],
    );
  }
}
