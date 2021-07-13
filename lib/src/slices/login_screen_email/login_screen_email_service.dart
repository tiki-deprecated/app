/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

import 'login_screen_email_controller.dart';
import 'login_screen_email_presenter.dart';
import 'model/login_screen_email_model.dart';

class LoginScreenEmailService extends ChangeNotifier {
  late final LoginScreenEmailModel model;
  late final LoginScreenEmailPresenter presenter;
  late final LoginScreenEmailController controller;
  final LoginFlowService loginFlowService;

  LoginScreenEmailService(this.loginFlowService) {
    model = LoginScreenEmailModel();
    controller = LoginScreenEmailController(this);
    presenter = LoginScreenEmailPresenter(this);
  }

  void onEmailChange(String email) {
    this.model.email = email;
    this.model.canSubmit = EmailValidator.validate(this.model.email);
    notifyListeners();
  }

  Future<void> submitEmail() async {
    if (this.model.canSubmit) {
      this.model.isError = false;
      bool res =
          await this.loginFlowService.requestOtp(email: this.model.email);
      if (!res) this.model.isError = true;
      notifyListeners();
    }
  }
}
