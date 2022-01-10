/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import 'model/wallet_screen_model.dart';
import 'wallet_screen_controller.dart';
import 'wallet_screen_presenter.dart';

class WalletScreenService extends ChangeNotifier {
  late final WalletScreenModel model;
  late final WalletScreenPresenter presenter;
  late final WalletScreenController controller;

  WalletScreenService() {
    model = WalletScreenModel();
    controller = WalletScreenController(this);
    presenter = WalletScreenPresenter(this);
  }
}
