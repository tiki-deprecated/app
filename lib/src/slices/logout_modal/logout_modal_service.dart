/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:login/login.dart';

import 'logout_modal_controller.dart';
import 'logout_modal_presenter.dart';

class LogoutModalService extends ChangeNotifier {
  late final LogoutModalPresenter presenter;
  late final LogoutModalController controller;
  final Login _login;

  LogoutModalService(this._login) {
    this.presenter = LogoutModalPresenter(this);
    this.controller = LogoutModalController(this);
  }

  Login get login => _login;
}
