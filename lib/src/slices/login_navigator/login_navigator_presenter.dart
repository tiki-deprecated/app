import 'package:app/src/slices/login_navigator/login_navigator_service.dart';
import 'package:app/src/slices/login_navigator/ui/login_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginNavigatorPresenter extends Page {
  final LoginNavigatorService loginNavigatorService;

  LoginNavigatorPresenter(this.loginNavigatorService);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: loginNavigatorService, child: LoginNavigator()));
  }
}
