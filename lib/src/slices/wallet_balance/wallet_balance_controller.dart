/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api_signup/api_signup_service.dart';
import 'wallet_balance_service.dart';

class WalletBalanceController {
  final WalletBalanceService service;

  WalletBalanceController(this.service);

  Future<void> updateBalance(BuildContext context) async {
    ApiSignupService apiSignupService =
        Provider.of<ApiSignupService>(context, listen: false);
    service.updateBalance(apiSignupService);
  }
}
