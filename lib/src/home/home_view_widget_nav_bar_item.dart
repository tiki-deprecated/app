/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class HomeViewWidgetNavBarItem extends BottomNavigationBarItem {
  static const double _paddingTop = 12;
  static const double _paddingBottom = 8;

  HomeViewWidgetNavBarItem(String label, IconData icon)
      : super(
            icon: _getIcon(icon, ColorProvider.blue),
            label: label,
            activeIcon: _getIcon(icon, ColorProvider.orange));

  static Widget _getIcon(IconData icon, Color color) {
    return Padding(
        padding: EdgeInsets.only(
            top: SizeProvider.instance.height(_paddingTop),
            bottom: SizeProvider.instance.height(_paddingBottom)),
        child:
            SizedBox(child: Icon(icon, color: color), width: double.infinity));
  }
}
