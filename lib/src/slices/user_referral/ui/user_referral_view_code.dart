/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/api_blockchain/api_blockchain_service.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:app/src/slices/user_referral/user_referral_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserReferralViewCode extends StatelessWidget {
  static const String _text = "YOUR CODE:";
  static const num _fontSize = 12;

  @override
  Widget build(BuildContext context) {
    UserReferralService userReferralService =
        Provider.of<UserReferralService>(context);
    LoginFlowService loginFlowService = Provider.of<LoginFlowService>(context);
    ApiBlockchainService apiBlockchainService =
        Provider.of<ApiBlockchainService>(context);
    return OutlinedButton(
        onPressed: () async => userReferralService.controller.copyLink(context),
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: ConfigColor.greyFour),
            primary: ConfigColor.greyFive,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1.h)))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(_text,
                style: TextStyle(
                    fontSize: _fontSize.sp,
                    fontWeight: FontWeight.bold,
                    color: ConfigColor.greyFive)),
            Container(
                margin: EdgeInsets.only(
                    left: 2.w, top: 1.5.h, right: 1.h, bottom: 1.5.h),
                child: Text(
                    userReferralService.getCode(
                        loginFlowService, apiBlockchainService),
                    style: TextStyle(
                        fontSize: _fontSize.sp,
                        fontWeight: FontWeight.bold,
                        color: ConfigColor.tikiBlue)))
          ]),
          HelperImage("icon-copy", height: _fontSize.sp),
        ]));
  }
}
