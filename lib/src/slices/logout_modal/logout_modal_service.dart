/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import 'logout_modal_controller.dart';
import 'logout_modal_presenter.dart';

class LogoutModalService extends ChangeNotifier {
  late final LogoutModalPresenter presenter;
  late final LogoutModalController controller;

  LogoutModalService() {
    this.presenter = LogoutModalPresenter(this);
    this.controller = LogoutModalController(this);
  }
}
