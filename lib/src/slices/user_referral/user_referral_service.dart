/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:login/login.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_signup/api_signup_service.dart';
import 'model/user_referral_model.dart';
import 'user_referral_controller.dart';
import 'user_referral_presenter.dart';

class UserReferralService extends ChangeNotifier {
  late final UserReferralPresenter presenter;
  late final UserReferralController controller;
  late final UserReferralModel model;
  final ApiAppDataService apiAppDataService;
  final ApiSignupService apiSignupService;
  final Login _login;

  UserReferralService(
      this.apiAppDataService, this.apiSignupService, this._login) {
    this.presenter = UserReferralPresenter(this);
    this.controller = UserReferralController(this);
    this.model = UserReferralModel();
    getCode();
  }

  Future<void> getCode() async {
    String? code = this.model.code;
    if (code.isEmpty) {
      await _updateCode();
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

  Future<void> _updateCode() async {
    String code =
        (await apiAppDataService.getByKey(ApiAppDataKey.userReferCode))
                ?.value ??
            '';
    if (code.isEmpty) {
      String? address = _login.user?.address;
      code = '????';
    }
    this.model.code = code;
    notifyListeners();
  }
}
