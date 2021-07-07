/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/wallet_screen/model/wallet_screen_model.dart';
import 'package:flutter/widgets.dart';

import 'wallet_screen_controller.dart';
import 'wallet_screen_presenter.dart';

class WalletScreenService extends ChangeNotifier {
  late WalletScreenModel model;
  late WalletScreenPresenter presenter;
  late WalletScreenController controller;

  WalletScreenService() {
    model = WalletScreenModel();
    controller = WalletScreenController();
    presenter = WalletScreenPresenter(this);
  }

  Widget getUI() {
    return this.presenter.render();
  }
}
