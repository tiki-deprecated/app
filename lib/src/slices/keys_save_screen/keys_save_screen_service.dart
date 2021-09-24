import 'package:flutter/material.dart';

import '../login_flow/login_flow_service.dart';
import 'keys_save_screen_controller.dart';
import 'keys_save_screen_presenter.dart';
import 'model/keys_save_screen_model.dart';

class KeysSaveScreenService extends ChangeNotifier {
  late KeysSaveScreenPresenter presenter;
  late KeysSaveScreenController controller;
  late KeysSaveScreenServiceModel model;
  final LoginFlowService loginFlowService;

  KeysSaveScreenService(this.loginFlowService) {
    model = KeysSaveScreenServiceModel();
    presenter = KeysSaveScreenPresenter(this);
    controller = KeysSaveScreenController(this);
  }

  void keysSaved() {
    this.model.saved = true;
    notifyListeners();
  }

  void keysDownloaded() {
    this.model.downloaded = true;
    notifyListeners();
  }

  bool canContinue() {
    return this.model.saved || this.model.downloaded;
  }

  Future<void> saveAndLogin() async =>
      await this.loginFlowService.registerAndLogin();
}
