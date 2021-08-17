/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/data_screen/ui/data_screen_view_score.dart';
import 'package:app/src/widgets/link_account/link_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'data_screen_view_soon.dart';

class DataScreenLayoutBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataScreenService service = Provider.of<DataScreenService>(context);
    var isLinked = service.model.googleAccount != null;
    return GestureDetector(
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    DataScreenViewScore(
                        image: isLinked ? "data-score-happy" : "data-score-sad",
                        summary:
                            isLinked ? "All good!" : "Uh-oh. No data just yet!",
                        description: isLinked
                            ? "Your account is linked now. See what data Gmail holds on you by tapping on the button below."
                            : "Get started by adding a Gmail account",
                        color: isLinked ? ConfigColor.green : ConfigColor.blue),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: LinkAccount(
                        username: service.model.googleAccount?.email,
                        type: "Google",
                        linkedIcon: "account-soon-gmail",
                        unlinkedIcon: "google-icon",
                        onLink: () => service.controller.linkGmail(context),
                        onUnlink: () => service.removeGoogleAccount(),
                        onSee: () => service.controller.openGmailCards(context),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: DataScreenViewSoon())
                  ],
                ))));
  }
}
