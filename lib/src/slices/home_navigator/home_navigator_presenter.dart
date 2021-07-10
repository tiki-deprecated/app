import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/home_navigator/home_navigator_service.dart';
import 'package:app/src/slices/home_navigator/model/home_navigator_item_model.dart';
import 'package:app/src/slices/home_navigator/ui/home_navigator.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNavigatorPresenter extends Page {
  final HomeNavigatorService homeNavigatorService;

  HomeNavigatorPresenter(this.homeNavigatorService);

  get items => [
        HomeNavigatorItemModel(
          title: 'Data',
          selectedIcon: HelperImage('eye-icon-selected', width: 48),
          unSelectedIcon: HelperImage('eye-icon', width: 48),
        ),
        HomeNavigatorItemModel(
          title: 'Choices',
          selectedIcon: HelperImage('choices-icon-selected', width: 48),
          unSelectedIcon: HelperImage('choices-icon', width: 48),
        ),
        HomeNavigatorItemModel(
          title: 'Money',
          selectedIcon: HelperImage('money-icon-selected', width: 48),
          unSelectedIcon: HelperImage('money-icon', width: 48),
        ),
      ];

  get selectedColor => ConfigColor.orange;

  get unSelectedColor => ConfigColor.blue;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: homeNavigatorService, child: HomeNavigator()));
  }
}
