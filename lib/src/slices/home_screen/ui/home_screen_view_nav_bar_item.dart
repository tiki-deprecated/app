/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class HomeScreenViewNavBarItem extends BottomNavigationBarItem {
  static const double _size = 48;

  HomeScreenViewNavBarItem(String label, IconData icon) : super(
        icon: Icon(
            icon,
            color: ColorProvider.blue, size: SizeProvider.instance.size(_size)),
        label: label,
        activeIcon: Icon(
            icon,
            color: ColorProvider.orange, size: SizeProvider.instance.size(_size)),
      );
}
