/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/user_referral/ui/user_referral_layout.dart';
import 'package:app/src/slices/user_referral/user_referral_service.dart';
import 'package:provider/provider.dart';

class UserReferralPresenter {
  final UserReferralService service;

  UserReferralPresenter(this.service);

  ChangeNotifierProvider<UserReferralService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: UserReferralLayout());
  }
}
