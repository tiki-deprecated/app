/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

//import 'package:app/src/slices/data_fetch/model/data_fetch_model_msg.dart';
import 'package:logging/logging.dart';

import '../decision_screen/decision_screen_service.dart';
import 'package:flutter/material.dart';

import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_provider.dart';
import '../data_fetch/data_fetch_service.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  final _log = Logger('DataScreenService');
  late final DataScreenModel _model;
  late final DataScreenPresenter presenter;
  late final DataScreenController controller;
  final DataFetchService _dataFetchService;
  final ApiOAuthService _apiAuthService;

  late final DecisionScreenService decisionScreenService;

  get account => _model.account;

  DataScreenService(
      this._dataFetchService,
      this._apiAuthService,
      this.decisionScreenService) {
    _model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
    _apiAuthService.getAccount().then((account) {
      _model.account = account;
      if (account != null) _dataFetchService.asyncIndex(account);
      notifyListeners();
    });
  }

  Future<void> linkAccount(String provider) async {
    ApiOAuthModelAccount? account = await _apiAuthService.signIn(provider);
    if (account != null) {
      _model.account = account;
      _dataFetchService.asyncIndex(account);
      notifyListeners();
    }
  }

  Future<void> removeAccount() async {
    ApiOAuthModelAccount? account = await _apiAuthService.getAccount();
    if (account != null) {
      try {
        await _apiAuthService.signOut(account);
      }catch(e){
        _log.warning(e);
      }
      decisionScreenService.removeAllCards();
    }
    _model.account = null;
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>?> getInfoCards(int accountId) async {
    ApiOAuthModelAccount? account = _model.account;
    if (account != null) {
      DataFetchInterfaceProvider? provider = _apiAuthService
          .interfaceProviders[account.provider] as DataFetchInterfaceProvider?;
      if (provider?.email != null) return await provider!.getInfoCards(account);
    }
    return List<InfoCarouselCardModel>.empty();
  }
}
