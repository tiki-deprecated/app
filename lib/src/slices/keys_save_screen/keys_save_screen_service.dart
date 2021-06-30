import 'package:app/src/slices/keys_save_screen/keys_save_screen_controller.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_presenter.dart';
import 'package:flutter/material.dart';

class KeysSaveScreenService extends ChangeNotifier {
  late KeysSaveScreenPresenter presenter;
  late KeysSaveScreenController controller;
  late KeysSaveScreenServiceModel model;

  KeysSaveScreenService() {
    model = KeysSaveScreenServiceModel();
    presenter = KeysSaveScreenPresenter(this);
    controller = KeysSaveScreenController();
  }

  getUI() {
    return presenter.render();
  }

  void emailSaved() {
    this.model.savedEmail = true;
    notifyListeners();
  }

  void keySaved() {
    this.model.savedKeys = true;
    notifyListeners();
  }

  void keysDonwloaded() {
    this.model.downloaded = true;
    notifyListeners();
  }
}

class KeysSaveScreenServiceModel {
  bool savedEmail = false;
  bool savedKeys = false;
  bool downloaded = false;
}