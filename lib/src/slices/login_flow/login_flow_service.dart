/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/intro_screen/intro_screen_service.dart';
import 'package:app/src/slices/login_flow/login_flow_delegate.dart';
import 'package:app/src/slices/login_flow/login_flow_information_parser.dart';
import 'package:flutter/widgets.dart';

import 'model/login_flow_model.dart';

class LoginFlowService extends ChangeNotifier {
  late LoginFlowModel model;
  late LoginFlowDelegate delegate;
  late LoginFlowInformationParser informationParser;

  LoginFlowService() {
    this.model = LoginFlowModel();
    this.delegate = LoginFlowDelegate(this);
    this.informationParser = LoginFlowInformationParser();
  }

  List<Page> pages() {
    return [
      if (!this.model.isLogin) IntroScreenService().presenter,
      //if (this.model.isLogin) P2(),
    ];
  }

  void to() {
    this.model.isLogin = true;
    notifyListeners();
  }

  bool pop(Route<dynamic> route, result) {
    if (!route.didPop(result)) return false;
    this.model.isLogin = false;
    notifyListeners();
    return true;
  }
}
