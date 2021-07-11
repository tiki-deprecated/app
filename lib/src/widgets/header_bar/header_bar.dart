/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_size.dart';
import 'package:app/src/widgets/header_bar/header_bar_view_badge.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class HeaderBar extends StatelessWidget {
  final Function()? onTap;

  HeaderBar(this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, //UserAccountModalService().presenter.showModal(context),
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
