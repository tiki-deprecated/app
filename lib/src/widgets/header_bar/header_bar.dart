/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tiki_style/tiki_style.dart';
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
              Container(
                alignment: Alignment.centerLeft,
                height: SizeProvider.instance.height(30),
                width: SizeProvider.instance.width(30),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: ImgProvider.badgeBetaAvatar
                )
              ),
              const HeaderBarViewBadge("BETA TESTER")
            ],
          ),
        ));
  }
}
