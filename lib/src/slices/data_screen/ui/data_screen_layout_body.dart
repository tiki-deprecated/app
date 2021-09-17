/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../data_screen_service.dart';
import 'data_screen_layout_accounts.dart';
import 'data_screen_view_score.dart';
import 'data_screen_view_soon.dart';

class DataScreenLayoutBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataScreenService service = Provider.of<DataScreenService>(context);
    var isLinked = service.accounts.isNotEmpty;
    return GestureDetector(
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    // TODO check the wording for multiple providers/accounts
                    DataScreenViewScore(
                        image: isLinked ? "data-score-happy" : "data-score-sad",
                        summary:
                            isLinked ? "All good!" : "Uh-oh. No data just yet!",
                        description: isLinked
                            ? "Your account is linked now. See what data Gmail holds by tapping on the button below."
                            : "Get started by adding a Gmail account",
                        color: isLinked ? ConfigColor.green : ConfigColor.blue),
                    DecisionScreenLayoutAccounts(),
                    Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: DataScreenViewSoon())
                  ],
                ))));
  }
}
