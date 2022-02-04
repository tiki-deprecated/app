/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
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
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    return service.updateBalance(apiSignupService, apiAppDataService);
  }
}
