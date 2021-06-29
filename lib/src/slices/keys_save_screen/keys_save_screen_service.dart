import 'package:app/src/slices/keys_save_screen/keys_save_screen_controller.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_presenter.dart';
import 'package:flutter/material.dart';

class KeysSaveScreenService extends ChangeNotifier {
  late KeysSaveScreenPresenter presenter;
  late KeysSaveScreenController controller;

  KeysSaveScreenService() {
    presenter = KeysSaveScreenPresenter(this);
    controller = KeysSaveScreenController();
  }

  getUI() {
    return presenter.render();
  }
}
