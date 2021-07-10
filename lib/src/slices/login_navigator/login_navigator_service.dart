import 'package:app/src/slices/login_navigator/login_navigator_controller.dart';
import 'package:app/src/slices/login_navigator/login_navigator_presenter.dart';
import 'package:app/src/slices/login_navigator/model/login_navigator_model.dart';
import 'package:flutter/material.dart';

class LoginNavigatorService extends ChangeNotifier {
  late LoginNavigatorPresenter presenter;
  late LoginNavigatorController controller;
  late LoginNavigatorModel model;

  LoginNavigatorService() {
    model = LoginNavigatorModel();
    presenter = LoginNavigatorPresenter(this);
    controller = LoginNavigatorController();
  }

  getUI() {
    return presenter;
  }

  void goToSaveKeys() {
    this.model.currentScreen = LoginNavigatorModel.saveKeys;
    notifyListeners();
  }

  void goToRestoreKeys() {
    this.model.currentScreen = LoginNavigatorModel.restoreKeys;
    notifyListeners();
  }
}
