/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_signup/api_signup_service.dart';
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

  Future<void> updateBalance(ApiSignupService apiSignupService,
      ApiAppDataService apiAppDataService) async {
    ApiAppDataModel? appDataModel =
        await apiAppDataService.getByKey(ApiAppDataKey.userReferCode);
    if (appDataModel != null) {
      int? count = await apiSignupService.getTotal(code: appDataModel.value);
      if (count != null) {
        this.model.balance = 5.0 * (count ~/ 10.0);
        notifyListeners();
      }
    }
  }
}
