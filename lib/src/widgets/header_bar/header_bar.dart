/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:app/src/slices/api_short_code/api_short_code_service.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/config_size.dart';
import '../../slices/api_app_data/api_app_data_service.dart';
import '../../slices/api_signup/api_signup_service.dart';
import '../../slices/user_account_modal/user_account_modal_service.dart';
import '../../slices/user_referral/user_referral_service.dart';
import 'header_bar_view_badge.dart';

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context);
    ApiSignupService apiSignupService = Provider.of<ApiSignupService>(context);
    Login login = Provider.of<Login>(context, listen: false);
    UserReferralService userReferralService = UserReferralService(
        apiAppDataService,
        apiSignupService,
        login,
        Provider.of<ApiShortCodeService>(context, listen: false));

    // TODO fix bottom sheet modal service rebuilds in every tap
    return GestureDetector(
        onTap: () => UserAccountModalService(userReferralService, login)
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
