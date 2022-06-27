/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';
import 'package:tiki_user_account/tiki_user_account.dart';

import 'header_view_widget_badge.dart';

class HeaderViewLayout extends StatelessWidget {
  final TikiUserAccount userAccount;

  const HeaderViewLayout({Key? key, required this.userAccount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => userAccount.open(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(
            left: SizeProvider.instance.width(21),
            right: SizeProvider.instance.width(11),
            top: SizeProvider.instance.height(9),
            bottom: SizeProvider.instance.height(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: SizeProvider.instance.height(30),
                  width: SizeProvider.instance.width(30),
                  child: SizedBox.expand(
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: ImgProvider.avatarPineapple))),
              const HeaderViewWidgetBadge("BETA TESTER")
            ],
          ),
        ));
  }
}
