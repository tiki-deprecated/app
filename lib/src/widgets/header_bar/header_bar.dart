/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';
import 'package:tiki_user_account/tiki_user_account.dart';

import 'header_bar_view_badge.dart';

class HeaderBar extends StatelessWidget {
  final TikiUserAccount userAccount;

  const HeaderBar({Key? key, required this.userAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => userAccount.open(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(
            left: SizeProvider.instance.size(SizeProvider.marginHeaderH),
            right: SizeProvider.instance.size(SizeProvider.marginHeaderH),
            top: SizeProvider.instance.size(SizeProvider.marginHeaderT),
            bottom: SizeProvider.instance.size(SizeProvider.marginHeaderB),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: SizeProvider.instance.height(30),
                  width: SizeProvider.instance.width(30),
                  child: FittedBox(
                      fit: BoxFit.fill, child: ImgProvider.avatarPineapple)),
              const HeaderBarViewBadge("BETA TESTER")
            ],
          ),
        ));
  }
}
