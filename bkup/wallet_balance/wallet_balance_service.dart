/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'model/wallet_balance_model.dart';
import 'wallet_balance_controller.dart';
import 'wallet_balance_presenter.dart';

class WalletBalanceService extends ChangeNotifier {
  late WalletBalanceModel model;
  late WalletBalancePresenter presenter;
  late WalletBalanceController controller;

  WalletBalanceService() {
    model = WalletBalanceModel();
    controller = WalletBalanceController();
    presenter = WalletBalancePresenter(this);
  }

  Widget getUI() {
    return this.presenter.render();
  }

  updateBalance(BuildContext context) async {
    AppModelUser user = Provider.of<AppService>(context).model.user!;
    var code = user.code ?? "";
    var apiService = ApiService();
    int count = (await apiService.getReferCount(code))!;
    this.model.balance = 5.0 * (count ~/ 10.0);
    notifyListeners();
  }
}
