import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/home_navigator/home_navigator_service.dart';
import 'package:app/src/slices/home_navigator/ui/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNavigatorPresenter extends Page {
  final HomeNavigatorService homeNavigatorService;

  HomeNavigatorPresenter(this.homeNavigatorService);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: homeNavigatorService, child: HomeNavigator()));
  }

  Color getItemColor({required int index}) {
    return homeNavigatorService.model.currentScreenIndex == index
        ? ConfigColor.orange
        : ConfigColor.blue;
  }
}
