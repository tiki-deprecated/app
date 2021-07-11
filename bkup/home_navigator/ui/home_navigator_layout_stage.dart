import 'package:app/src/slices/home_navigator/home_navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNavigatorLayoutStage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentIndex =
        Provider.of<HomeNavigatorService>(context).model.currentScreenIndex;
    switch (currentIndex) {
      case 0:
        return Container(
            child: Text("Data Screen")); //DataScreenService().getUI();
      case 1:
        return Container(
            child: Text("Choices Screen")); //DataScreenService().getUI();
      case 2:
        return Container(
            child: Text("Money Screen")); //DataScreenService().getUI
    }
    return Container(child: Text("Data Screen"));
  }
}
