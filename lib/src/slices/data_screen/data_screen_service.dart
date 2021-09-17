/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../data_bkg/data_bkg_service.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  late final DataScreenModel model;
  late final DataScreenPresenter presenter;
  late final DataScreenController controller;
  final DataBkgService _dataBkgService;
  final ApiAuthService _apiAuthService;

  DataScreenService(this._dataBkgService, this._apiAuthService) {
    model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
  }

  Future<void> removeAccount(int accountId) async {
    await _dataBkgService.removeAccount(accountId);
    notifyListeners();
  }

  Future<void> linkAccount(String provider) async {
    ApiAuthServiceAccountModel? account =
        await _apiAuthService.linkAccount(provider);
    if (account != null) {
      _dataBkgService.addAccount(account);
      notifyListeners();
    }
  }

  Future<List<InfoCarouselCardModel>> getInfoCards(int accountId) async {
    return await _dataBkgService.getInfoCards(accountId);
  }

  List<ApiAuthServiceAccountModel> getAccountList() {
    return _dataBkgService.getAccountList();
  }

  List<String> getProvidersList() {
    return _apiAuthService.getProviders();
  }

  List<ApiAuthServiceAccountModel> getAccountsByProvider(String provider) {
    // getting accounts from databkgservice because apiauth needs to await
    return _dataBkgService.getAccountsByProvider(provider);
  }
}
