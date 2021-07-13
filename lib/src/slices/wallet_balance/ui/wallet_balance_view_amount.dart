/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../wallet_balance_service.dart';

class WalletBalanceViewAmount extends StatelessWidget {
  static const String _text = "your balance";

  @override
  Widget build(BuildContext context) {
    var balance = Provider.of<WalletBalanceService>(context).model.balance;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "\$" + balance.toStringAsFixed(0),
            textAlign: TextAlign.right,
            style: TextStyle(
                color: ConfigColor.tikiBlue,
                fontFamily: "Koara",
                fontWeight: FontWeight.bold,
                height: 0,
                fontSize: 64.sp),
          ),
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: Text(
                _text,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: ConfigColor.greySix,
                    fontFamily: "Koara",
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp),
              ))
        ]);
  }
}
