/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'home_service.dart';
import 'home_view_widget_nav_bar_item.dart';

class HomeViewWidgetNavBar extends StatelessWidget {
  static const double _fontSize = 15;
  static const double _radius = 50;

  const HomeViewWidgetNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeService service = Provider.of<HomeService>(context);
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(_radius)),
          boxShadow: [
            BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(4.0, 4.0),
                blurRadius: 20),
          ],
        ),
        child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(_radius)),
            child: BottomNavigationBar(
              currentIndex: service.model.currentScreenIndex,
              onTap: (index) => service.controller.onNavTap(index),
              items: [
                HomeViewWidgetNavBarItem("Data", IconProvider.eye),
                HomeViewWidgetNavBarItem("Choices", IconProvider.choices_1),
                HomeViewWidgetNavBarItem("Money", IconProvider.money)
              ],
              backgroundColor: ColorProvider.white,
              unselectedItemColor: ColorProvider.blue,
              unselectedLabelStyle: TextStyle(
                  fontFamily: TextProvider.familyNunitoSans,
                  package: 'tiki_style',
                  fontWeight: FontWeight.w800,
                  fontSize: SizeProvider.instance.text(_fontSize)),
              selectedItemColor: ColorProvider.orange,
              selectedLabelStyle: TextStyle(
                  fontFamily: TextProvider.familyNunitoSans,
                  package: 'tiki_style',
                  fontWeight: FontWeight.w800,
                  fontSize: SizeProvider.instance.text(_fontSize)),
            )));
  }
}
