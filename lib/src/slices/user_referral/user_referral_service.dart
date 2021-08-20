/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_app_data/api_app_data_key.dart';
import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
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
  final ApiAppDataService apiAppDataService;
  final LoginFlowService loginFlowService;
  final ApiSignupService apiSignupService;

  UserReferralService(
      this.apiAppDataService, this.loginFlowService, this.apiSignupService) {
    this.presenter = UserReferralPresenter(this);
    this.controller = UserReferralController(this);
    this.model = UserReferralModel();
    getCode();
  }

  Future<void> getCode() async {
    String? code = this.model.code;
    if (code.isEmpty) {
      await _updateCode(this.apiAppDataService, this.loginFlowService);
      updateReferCount();
    }
    notifyListeners();
  }

  updateReferCount() async {
    String? code =
        (await this.apiAppDataService.getByKey(ApiAppDataKey.userReferCode))
            ?.value;
    if (code != null) {
      int? count = await this.apiSignupService.getTotal(code: code);
      if (count != null) {
        this.model.referCount = count;
        notifyListeners();
      }
    }
  }

  Future<void> _updateCode(ApiAppDataService apiAppDataService,
      LoginFlowService loginFlowService) async {
    String code =
        (await apiAppDataService.getByKey(ApiAppDataKey.userReferCode))
                ?.value ??
            '';
    if (code.isEmpty) {
      String address = loginFlowService.model.user!.user!.address!;
      HelperApiRsp<ApiBlockchainModelAddressRspCode> rsp =
          await loginFlowService.apiBlockchainService.referCode(address);
      if (HelperApiUtils.isOk(rsp.code)) {
        ApiBlockchainModelAddressRspCode data = rsp.data;
        code = data.code ?? '';
        await apiAppDataService.save(ApiAppDataKey.userReferCode, code);
      }
    }
    this.model.code = code;
    notifyListeners();
  }
}
