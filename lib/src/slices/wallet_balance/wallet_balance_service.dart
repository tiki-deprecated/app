/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import '../api_signup/api_signup_service.dart';
import '../login_flow/login_flow_service.dart';
import 'model/wallet_balance_model.dart';
import 'wallet_balance_controller.dart';
import 'wallet_balance_presenter.dart';

class WalletBalanceService extends ChangeNotifier {
  late final WalletBalanceModel model;
  late final WalletBalancePresenter presenter;
  late final WalletBalanceController controller;

  WalletBalanceService() {
    model = WalletBalanceModel();
    controller = WalletBalanceController(this);
    presenter = WalletBalancePresenter(this);
  }

  updateBalance(LoginFlowService loginFlowService,
      ApiSignupService apiSignupService) async {
    String? code = loginFlowService.model.user!.user!.code;
    if (code != null) {
      // int? count = await apiSignupService.getTotal(code: code);
      // if (count != null) {
      //   this.model.balance = 5.0 * (count ~/ 10.0);
      //   notifyListeners();
      // }
    }
  }
}
