/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

class HomeScreenViewNavBarItem extends BottomNavigationBarItem {
  static const double _width = 48;

  HomeScreenViewNavBarItem(String label, String icon)
      : super(
            icon: Image(
              image: AssetImage('res/images/' + icon + '.png'),
              width: _width,
              fit: BoxFit.fitWidth,
            ),
            label: label,
            activeIcon: Image(
              image: AssetImage('res/images/' + icon + '-selected.png'),
              width: _width,
              fit: BoxFit.fitWidth,
            ));
}
