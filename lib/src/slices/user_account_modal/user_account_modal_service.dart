/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import '../api_signup/api_signup_service.dart';
import '../user_referral/user_referral_service.dart';
import 'model/user_account_modal_model.dart';
import 'user_account_modal_controller.dart';
import 'user_account_modal_presenter.dart';

class UserAccountModalService extends ChangeNotifier {
  late final UserAccountModalPresenter presenter;
  late final UserAccountModalController controller;
  late final UserAccountModalModel model;
  UserReferralService referralService;

  UserAccountModalService(this.referralService) {
    this.presenter = UserAccountModalPresenter(this);
    this.controller = UserAccountModalController(this);
    this.model = UserAccountModalModel();
  }

  Future<void> updateSignups(ApiSignupService apiSignupService) async {
    int? total = await apiSignupService.getTotal();
    if (total != null) {
      this.model.signupCount = total;
      notifyListeners();
    }
  }

  goToSupport() {}
}
