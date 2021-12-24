/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_size.dart';
import '../../slices/api_app_data/api_app_data_service.dart';
import '../../slices/api_blockchain/api_blockchain_service.dart';
import '../../slices/api_signup/api_signup_service.dart';
import '../../slices/login_flow/login_flow_service.dart';
import '../../slices/user_account_modal/user_account_modal_service.dart';
import '../../slices/user_referral/user_referral_service.dart';
import 'header_bar_view_badge.dart';

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginFlowService loginFlowService = Provider.of<LoginFlowService>(context);
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context);
    ApiSignupService apiSignupService = Provider.of<ApiSignupService>(context);
    ApiBlockchainService apiBlockchainService =
        Provider.of<ApiBlockchainService>(context);
    UserReferralService userReferralService = UserReferralService(
        apiAppDataService,
        loginFlowService,
        apiSignupService,
        apiBlockchainService);
    // TODO fix bottom sheet modal service rebuilds in every tap
    return GestureDetector(
        onTap: () => UserAccountModalService(userReferralService)
            .presenter
            .showModal(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(
              left: ConfigSize.marginHeaderH.w,
              right: ConfigSize.marginHeaderH.w,
              top: ConfigSize.marginHeaderT.h,
              bottom: ConfigSize.marginHeaderB.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('res/images/badge-beta-avatar.png'),
                height: 4.h,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
              HeaderBarViewBadge("BETA TESTER")
            ],
          ),
        ));
  }
}
