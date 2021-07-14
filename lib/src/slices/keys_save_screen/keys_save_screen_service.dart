import 'package:app/src/slices/keys_save_screen/keys_save_screen_controller.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_presenter.dart';
import 'package:app/src/slices/keys_save_screen/model/keys_save_screen_model.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:flutter/material.dart';

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
