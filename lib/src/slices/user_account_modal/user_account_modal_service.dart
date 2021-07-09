/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api/api_service.dart';
import 'package:app/src/slices/user_account_modal/model/user_account_modal_model.dart';
import 'package:app/src/slices/user_account_modal/user_account_modal_controller.dart';
import 'package:app/src/slices/user_account_modal/user_account_modal_presenter.dart';
import 'package:app/src/slices/user_referral/user_referral_service.dart';
import 'package:flutter/widgets.dart';

class UserAccountModalService extends ChangeNotifier {
  late UserAccountModalPresenter presenter;
  late UserAccountModalController controller;
  late UserAccountModalModel model;
  late UserReferralService referralService;

  UserAccountModalService({UserReferralService? referralService}) {
    this.presenter = UserAccountModalPresenter(this);
    this.controller = UserAccountModalController(this);
    this.model = UserAccountModalModel();
    this.referralService = referralService ?? UserReferralService();
    updateSignups();
  }

  Widget getUI() {
    return this.presenter.render();
  }

  int? getSignups() {
    if (this.model.signupCount == null) updateSignups();
    return this.model.signupCount;
  }

  updateSignups() async {
    var apiService = ApiService();
    var total = await apiService.getTotal();
    this.model.signupCount = total;
    notifyListeners();
  }
}
