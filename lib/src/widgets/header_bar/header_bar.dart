/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/user_account_modal/user_account_modal_service.dart';
import 'package:app/src/widgets/header_bar/header_bar_view_badge.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4.6.w, right: 4.6.w, top: 1.h, bottom: 3.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () => UserAccountModalService().presenter.showModal(context),
            child: Image(
              image: AssetImage('res/images/icon-account.png'),
              height: 4.h,
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
            ),
          )),
          HeaderBarViewBadge("BETA TESTER")
        ],
      ),
    );
  }
}
