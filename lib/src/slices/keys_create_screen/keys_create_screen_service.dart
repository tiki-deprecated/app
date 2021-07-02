import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/keys/keys_service.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_controller.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_presenter.dart';
import 'package:flutter/material.dart';

import 'model/keys_create_screen_model.dart';

class KeysCreateScreenService extends ChangeNotifier {
  late KeysCreateScreenPresenter presenter;
  late KeysCreateScreenController controller;
  late KeysCreateScreenModel model;

  AppService appService;

  KeysCreateScreenService(this.appService) {
    presenter = KeysCreateScreenPresenter(this);
    controller = KeysCreateScreenController();
    model = KeysCreateScreenModel();
  }

  getUI() {
    generateKeys();
    return presenter.render();
  }

  Future<void> generateKeys() async {
    var keysWithAddress = await KeysService().generateKeysAndIssueAddress();
    await appService.keysGenerated(keysWithAddress);
    await Future.delayed(Duration(
        milliseconds:
            1500)); //TODO this should wait at least 3 seconds, not add 3 seconds to every generate
  }

  void setStarted(bool state) {
    model.isStarted = state;
    notifyListeners();
  }

  void setComplete(bool state) {
    model.isComplete = state;
    notifyListeners();
  }
}
