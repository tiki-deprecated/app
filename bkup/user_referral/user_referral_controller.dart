/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/user_referral/user_referral_service.dart';
import 'package:provider/provider.dart';

class UserReferralController {
  copyLink(context) async {
    await Provider.of<UserReferralService>(context, listen: false).copyLink();
  }
}
