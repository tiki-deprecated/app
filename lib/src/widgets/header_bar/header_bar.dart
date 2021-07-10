/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/user_account_modal/user_account_modal_service.dart';
import 'package:app/src/widgets/header_bar/header_bar_view_badge.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class HeaderBar extends StatelessWidget {
  static const num _paddingHoriz = 4.6;
  static const num _paddingTop = 1;
  static const num _paddingBottom = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => UserAccountModalService().presenter.showModal(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(
              left: _paddingHoriz.w,
              right: _paddingHoriz.w,
              top: _paddingTop.h,
              bottom: _paddingBottom.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('res/images/icon-account.png'),
                height: 4.h,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
              HeaderBarViewBadge("BETA TESTER")
            ],
          ),
        ));
  }
}
