/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import '../api_signup/api_signup_service.dart';
import '../api_user/model/api_user_model_keys.dart';
import '../login_flow/login_flow_service.dart';
import '../user_referral/user_referral_service.dart';
import 'model/user_account_modal_model.dart';
import 'user_account_modal_controller.dart';
import 'user_account_modal_presenter.dart';

class UserAccountModalService extends ChangeNotifier {
  late final UserAccountModalPresenter presenter;
  late final UserAccountModalController controller;
  late final UserAccountModalModel model;
  late final LoginFlowService loginFlowService;

  UserReferralService referralService;


  UserAccountModalService(this.referralService, this.loginFlowService) {
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

  void showQrCode() {
    ApiUserModelKeys keys = this.loginFlowService.model.user!.keys!;
    String combinedKey = keys.address! + '.' + keys.dataPrivateKey! + '.' + keys.signPrivateKey!;
    this.model.showQrCode = true;
    this.model.qrCode = combinedKey;
    notifyListeners();
  }

  void hideQrCode() {
    this.model.showQrCode = false;
    this.notifyListeners();
  }
}
