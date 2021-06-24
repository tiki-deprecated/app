import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/auth/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'login_screen_controller.dart';
import 'login_screen_presenter.dart';
import 'model/login_screen_model.dart';

class LoginScreenService extends ChangeNotifier {
  late LoginScreenModel model;
  late LoginScreenPresenter presenter;
  late LoginScreenController controller;

  LoginScreenService() {
    model = LoginScreenModel();
    controller = LoginScreenController();
    presenter = LoginScreenPresenter(this);
  }

  bool _isValidEmail() {
    return EmailValidator.validate(this.model.email);
  }

  void onEmailChange(String email) {
    this.model.email = email;
    this.model.canSubmit = _isValidEmail();
    notifyListeners();
  }

  void submitEmail(BuildContext context) async {
    if (this.model.canSubmit) {
      AuthService authService = Provider.of<AppService>(context).authService;
      var result = await authService.requestOtp(this.model.email);
      if (result) {
        otpSubmitted();
      } else {
        otpError(context);
      }
    }
  }

  void otpError(context) {
    this.model.submitted = false;
    this.model.isError = true;
    Navigator.of(context).pop();
  }

  Widget getUI() {
    return this.presenter.render();
  }

  void otpSubmitted() {
    this.model.submitted = true;
    this.model.isError = false;
  }
}
