/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import 'ui/user_referral_layout.dart';
import 'user_referral_service.dart';

class UserReferralPresenter {
  final UserReferralService service;

  UserReferralPresenter(this.service);

  ChangeNotifierProvider<UserReferralService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: UserReferralLayout());
  }
}
