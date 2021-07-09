import 'package:app/src/slices/home_navigator/home_navigator_controller.dart';
import 'package:app/src/slices/home_navigator/home_navigator_presenter.dart';
import 'package:app/src/slices/home_navigator/model/home_navigator_model.dart';
import 'package:flutter/material.dart';

class HomeNavigatorService extends ChangeNotifier {
  late HomeNavigatorPresenter presenter;
  late HomeNavigatorController controller;
  late HomeNavigatorModel model;

  HomeNavigatorService() {
    model = HomeNavigatorModel();
    presenter = HomeNavigatorPresenter(this);
    controller = HomeNavigatorController();
  }

  getUI() {
    return presenter;
  }

  void goTo(int i) {
    model.currentScreenIndex = i;
    notifyListeners();
  }
}
