/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_signup/api_signup_service.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:app/src/slices/user_referral/model/user_referral_model.dart';
import 'package:app/src/slices/user_referral/user_referral_controller.dart';
import 'package:app/src/slices/user_referral/user_referral_presenter.dart';
import 'package:flutter/widgets.dart';

class UserReferralService extends ChangeNotifier {
  late final UserReferralPresenter presenter;
  late final UserReferralController controller;
  late final UserReferralModel model;

  bool isReferCountUpdated = false;

  UserReferralService() {
    this.presenter = UserReferralPresenter(this);
    this.controller = UserReferralController(this);
    this.model = UserReferralModel();
  }

  String getCode(LoginFlowService loginFlowService) {
    String? code = loginFlowService.model.user!.user!.code;
    if (code == null || code.isEmpty) _updateCode(loginFlowService);
    return code ?? "";
  }

  updateReferCount(LoginFlowService loginFlowService,
      ApiSignupService apiSignupService) async {
    if (!isReferCountUpdated) {
      String? code = loginFlowService.model.user!.user!.code;
      if (code != null) {
        int? count = await apiSignupService.getTotal(code: code);
        if (count != null) {
          this.model.referCount = count;
          notifyListeners();
        }
      }
    }
    isReferCountUpdated = true;
  }

  void _updateCode(LoginFlowService loginFlowService) async {
    await loginFlowService.updateCode();
    notifyListeners();
  }
}
