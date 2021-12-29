/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../api_app_data/api_app_data_service.dart';
import '../../api_blockchain/api_blockchain_service.dart';
import '../../api_signup/api_signup_service.dart';
import '../../login_flow/login_flow_service.dart';
import '../../user_referral/user_referral_service.dart';

class WalletScreenViewReferral extends StatelessWidget {
  static const String _text = "YOUR REFERRALS";

  @override
  Widget build(BuildContext context) {
    LoginFlowService loginFlowService = Provider.of<LoginFlowService>(context);
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context);
    ApiSignupService apiSignupService = Provider.of<ApiSignupService>(context);
    ApiBlockchainService apiBlockchainService =
        Provider.of<ApiBlockchainService>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ConfigColor.white,
        borderRadius: BorderRadius.circular(3.w),
        /*boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2.w,
            offset: Offset(0.75.w, 0.75.w), // Shadow position
          ),
        ],*/
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _text,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: ConfigColor.tikiBlue),
              ),
              Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: UserReferralService(
                          apiAppDataService,
                          loginFlowService,
                          apiSignupService,
                          apiBlockchainService)
                      .presenter
                      .render())
            ],
          )),
    );
  }
}
