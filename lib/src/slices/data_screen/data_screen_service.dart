/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_interface_provider.dart';
import '../data_bkg/data_bkg_service.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  late final DataScreenModel _model;
  late final DataScreenPresenter presenter;
  late final DataScreenController controller;
  final DataBkgService _dataBkgService;
  final ApiOAuthService _apiAuthService;

  get account => _model.account;

  DataScreenService(this._dataBkgService, this._apiAuthService) {
    _model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
  }

  Future<void> linkAccount(String provider) async {
    ApiOAuthModelAccount? account = await _apiAuthService.signIn(provider);
    if (account != null) {
      _model.account = account;
      _dataBkgService.index(account);
      notifyListeners();
    }
  }

  Future<void> removeAccount() async {
    ApiOAuthModelAccount? account = await _apiAuthService.getAccount();
    if (account != null) _apiAuthService.signOut(account);
    _model.account = null;
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>> getInfoCards(int accountId) async {
    ApiOAuthModelAccount? account = _model.account;
    if (account != null) {
      DataBkgInterfaceProvider? provider = _apiAuthService
          .providers[account.provider] as DataBkgInterfaceProvider?;
      if (provider?.email != null) return await provider!.getInfoCards(account);
    }
    return List<InfoCarouselCardModel>.empty();
  }
}
