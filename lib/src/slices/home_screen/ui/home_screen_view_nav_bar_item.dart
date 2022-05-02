/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class HomeScreenViewNavBarItem extends BottomNavigationBarItem {
  static const double _size = 24;
  static const double _fontSize = 15;

  HomeScreenViewNavBarItem(String label, IconData icon)
      : super(
            icon: _getButton(label, ColorProvider.blue, icon),
            label: "",
            activeIcon: _getButton(label, ColorProvider.orange, icon));

  static Widget _getButton(String label, Color color, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(
                top: SizeProvider.instance.size(_fontSize * 0.75)),
            alignment: Alignment.center,
            child: Icon(icon,
                color: color, size: SizeProvider.instance.size(_size))),
        Container(
            margin: EdgeInsets.only(
                top: SizeProvider.instance.size(_fontSize),
                left: label == "Data" ? SizeProvider.instance.size(10) : 0),
            width: SizeProvider.instance.size(_size * 3),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: TextProvider.familyNunitoSans,
                package: 'tiki_style',
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: SizeProvider.instance.text(_fontSize),
              ),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
