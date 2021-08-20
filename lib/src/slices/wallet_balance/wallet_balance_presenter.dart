/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import 'ui/wallet_balance_layout.dart';
import 'wallet_balance_service.dart';

class WalletBalancePresenter {
  final WalletBalanceService service;

  WalletBalancePresenter(this.service);

  ChangeNotifierProvider<WalletBalanceService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: WalletBalanceLayout());
  }
}
