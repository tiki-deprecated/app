/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_blockchain/model/api_blockchain_model_address_rsp_code.dart';
import 'package:app/src/slices/api_signup/api_signup_service.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:app/src/slices/user_referral/model/user_referral_model.dart';
import 'package:app/src/slices/user_referral/user_referral_controller.dart';
import 'package:app/src/slices/user_referral/user_referral_presenter.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';
import 'package:app/src/utils/api/helper_api_utils.dart';
import 'package:flutter/widgets.dart';

class UserReferralService extends ChangeNotifier {
  late final UserReferralPresenter presenter;
  late final UserReferralController controller;
  late final UserReferralModel model;

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
    String? code = loginFlowService.model.user!.user!.code;
    if (code != null) {
      int? count = await apiSignupService.getTotal(code: code);
      if (count != null) {
        this.model.referCount = count;
        notifyListeners();
      }
    }
  }

  void _updateCode(LoginFlowService loginFlowService) async {
    HelperApiRsp<ApiBlockchainModelAddressRspCode> rsp = await loginFlowService
        .apiBlockchainService
        .referCode(loginFlowService.model.user!.user!.address!);
    if (HelperApiUtils.isOk(rsp.code)) {
      ApiBlockchainModelAddressRspCode data = rsp.data;
      loginFlowService.model.user!.user!.code = data.code;
      await loginFlowService.apiUserService
          .setUser(loginFlowService.model.user!.user!);
      await loginFlowService.loadUser();
      notifyListeners();
    }
  }
}
