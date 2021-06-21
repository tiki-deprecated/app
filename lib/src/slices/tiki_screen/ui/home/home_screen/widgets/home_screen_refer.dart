/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/home/home_screen/widgets/home_screen_refer_code.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_refer_text.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';

import 'home_screen_refer_count.dart';

class HomeScreenRefer extends StatelessWidget {
  static final double _marginTopCode = 1 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCount = 1 * PlatformRelativeSize.blockVertical;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HomeScreenReferText(),
      Container(
          margin: EdgeInsets.only(top: _marginTopCode),
          child: HomeScreenReferCode()),
      Container(
          margin: EdgeInsets.only(top: _marginTopCount),
          child: HomeScreenReferCount())
    ]);
  }
}
