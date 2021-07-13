/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/wallet_balance/wallet_balance_service.dart';
import 'package:app/src/slices/wallet_screen/ui/wallet_screen_view_cash_out.dart';
import 'package:app/src/slices/wallet_screen/ui/wallet_screen_view_referral.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WalletScreenLayoutBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    WalletBalanceService().presenter.render(),
                    Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: WalletScreenViewCashOut()),
                    Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: WalletScreenViewReferral()),
                  ],
                ))));
  }
}
