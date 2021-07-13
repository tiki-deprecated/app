/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:flutter/cupertino.dart';

import 'login_screen_inbox_controller.dart';
import 'login_screen_inbox_presenter.dart';
import 'model/login_screen_inbox_model.dart';

class LoginScreenInboxService extends ChangeNotifier {
  late final LoginScreenInboxModel model;
  late final LoginScreenInboxPresenter presenter;
  late final LoginScreenInboxController controller;
  final LoginFlowService loginFlowService;

  LoginScreenInboxService(this.loginFlowService) {
    model = LoginScreenInboxModel();
    model.email = loginFlowService.model.user!.current!.email!;
    controller = LoginScreenInboxController(this);
    presenter = LoginScreenInboxPresenter(this);
  }

  Future<void> resendEmail() async => await this.loginFlowService.requestOtp();

  void back() {
    this.loginFlowService.setReturningUser();
    notifyListeners();
  }
}
