/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/wallet_balance/ui/wallet_balance_view_amount.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../wallet_balance_service.dart';
import 'wallet_balance_view_banner.dart';
import 'wallet_balance_view_card.dart';
import 'wallet_balance_view_soon.dart';

class WalletBalanceLayout extends StatelessWidget {
  static const num _borderRadius = 4;

  @override
  Widget build(BuildContext context) {
    Provider.of<WalletBalanceService>(context).updateBalance(context);
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius.w),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 2.w,
              offset: Offset(0.75.w, 0.75.w), // Shadow position
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(_borderRadius.w),
            child: Stack(children: [
              WalletBalanceViewCard(),
              WalletBalanceViewBanner(),
              Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 5.w),
                          child: WalletBalanceViewSoon()),
                      Container(
                          margin: EdgeInsets.only(right: 5.w),
                          child: WalletBalanceViewAmount())
                    ],
                  ))
            ])));
  }
}
