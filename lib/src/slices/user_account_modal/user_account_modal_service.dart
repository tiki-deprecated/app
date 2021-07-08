/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/user_account_modal/model/user_account_modal_model.dart';
import 'package:app/src/slices/user_account_modal/user_account_modal_controller.dart';
import 'package:app/src/slices/user_account_modal/user_account_modal_presenter.dart';
import 'package:flutter/widgets.dart';

class UserAccountModalService extends ChangeNotifier {
  late UserAccountModalPresenter presenter;
  late UserAccountModalController controller;
  late UserAccountModalModel model;

  UserAccountModalService() {
    this.presenter = UserAccountModalPresenter(this);
    this.controller = UserAccountModalController();
    this.model = UserAccountModalModel();
  }

  Widget getUI() {
    return this.presenter.render();
  }
}
