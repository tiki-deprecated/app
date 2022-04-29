/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:user_account/user_account.dart';

import '../../../../bkp/config_size.dart';
import 'header_bar_view_badge.dart';

class HeaderBar extends StatelessWidget {
  final UserAccount userAccount;

  const HeaderBar({Key? key, required this.userAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () => userAccount.open(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(
              left: ConfigSize.marginHeaderH.w,
              right: ConfigSize.marginHeaderH.w,
              top: ConfigSize.marginHeaderT.h,
              bottom: ConfigSize.marginHeaderB.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: const AssetImage('res/images/badge-beta-avatar.png'),
                height: 4.h,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
              const HeaderBarViewBadge("BETA TESTER")
            ],
          ),
        ));
  }
}
