/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/login.dart';
import 'package:wallet/wallet.dart';

import '../user_referral/user_referral_service.dart';
import 'model/user_account_modal_model.dart';
import 'user_account_modal_controller.dart';
import 'user_account_modal_presenter.dart';

class UserAccountModalService extends ChangeNotifier {
  late final UserAccountModalPresenter presenter;
  late final UserAccountModalController controller;
  late final UserAccountModalModel model;
  late final TikiKeysService _tikiKeysService;
  final Login _login;
  final UserReferralService referralService;

  UserAccountModalService(this.referralService, this._login) {
    this.presenter = UserAccountModalPresenter(this);
    this.controller = UserAccountModalController(this);
    this.model = UserAccountModalModel();
    _tikiKeysService = TikiKeysService(secureStorage: FlutterSecureStorage());
  }

  Login get login => _login;

  Future<void> updateSignups() async {
    int? total = await referralService.apiSignupService.getTotal();
    if (total != null) {
      this.model.signupCount = total;
      notifyListeners();
    }
  }

  Future<void> showQrCode() async {
    TikiKeysModel? keys = await _tikiKeysService.get(_login.user!.address!);
    if (keys != null) {
      String combinedKey = keys.address +
          '.' +
          keys.data.encode() +
          '.' +
          keys.sign.privateKey.encode();
      this.model.showQrCode = true;
      this.model.qrCode = combinedKey;
      notifyListeners();
    }
  }

  void hideQrCode() {
    this.model.showQrCode = false;
    this.notifyListeners();
  }
}
