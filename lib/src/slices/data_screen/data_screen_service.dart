/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api_oauth/api_oauth_interface_provider.dart';
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
    _loadAccount();
  }

  Future<void> linkAccount(String provider) async {
    ApiOAuthModelAccount? account = await _apiAuthService.signIn(provider);
    if (account != null) {
      this._addAccount(account);
    }
  }

  Future<void> removeAccount() async {
    ApiOAuthModelAccount? account = await _apiAuthService.getAccount();
    if (account != null) _apiAuthService.signOut(account);
    _model.account.removeWhere((account) => account.accountId == accountId);
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>> getInfoCards(int accountId) async {
    List<ApiOAuthModelAccount> account = _model.account
        .where((account) => account.accountId == accountId)
        .toList();
    if (account.isNotEmpty) {
      ApiOAuthModelAccount account = account[0];
      DataBkgInterfaceProvider? provider =
          _apiAuthService.getProvider(account) as DataBkgInterfaceProvider?;
      if (provider?.emailProvider != null)
        return await provider!.getInfoCards(account);
    }
    return List<InfoCarouselCardModel>.empty();
  }

  List<String> getProviders() {
    return _apiAuthService.getProviders();
  }

  List<ApiOAuthModelAccount> getAccounts(String provider) {
    return _model.accounts
        .where((account) => account.provider == provider)
        .toList();
  }

  void _addAccount(ApiOAuthModelAccount account) {
    ApiOAuthInterfaceProvider? providerService =
        _apiAuthService.getProvider(account);
    if (providerService != null) {
      providerService.logIn(account);
      _model.accounts.add(account);
      _dataBkgService.fetchData(account);
    }
    notifyListeners();
  }

  Future<void> _loadAccounts() async {
    _model.accounts = await _apiAuthService.getAllAccounts();
    notifyListeners();
  }
}
