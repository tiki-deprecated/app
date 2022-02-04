/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:login/login.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_short_code/api_short_code_service.dart';
import '../api_signup/api_signup_service.dart';
import 'model/user_referral_model.dart';
import 'user_referral_controller.dart';
import 'user_referral_presenter.dart';

class UserReferralService extends ChangeNotifier {
  final Logger _log = Logger('UserReferralService');

  late final UserReferralPresenter presenter;
  late final UserReferralController controller;
  late final UserReferralModel model;
  final ApiAppDataService apiAppDataService;
  final ApiSignupService apiSignupService;
  final ApiShortCodeService apiShortCodeService;
  final Login _login;

  UserReferralService(this.apiAppDataService, this.apiSignupService,
      this._login, this.apiShortCodeService) {
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
      await apiShortCodeService.get(
        accessToken: _login.token!.bearer!,
        address: _login.user!.address!,
        onSuccess: (rsp) async {
          code = rsp.code ?? '';
          await apiAppDataService.save(ApiAppDataKey.userReferCode, code);
        },
        onError: (error) => _log.warning(error),
      );
    }
    this.model.code = code;
    notifyListeners();
  }
}
