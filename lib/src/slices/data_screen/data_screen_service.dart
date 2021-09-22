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
  late final DataScreenModel model;
  late final DataScreenPresenter presenter;
  late final DataScreenController controller;
  final DataBkgService _dataBkgService;
  final ApiOAuthService _apiAuthService;

  late List<ApiOAuthModelAccount> _accounts = List.empty(growable: true);

  get accounts => _accounts;

  DataScreenService(this._dataBkgService, this._apiAuthService) {
    model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
    _loadAccounts();
  }

  Future<void> linkAccount(String provider) async {
    ApiOAuthModelAccount? account = await _apiAuthService.linkAccount(provider);
    if (account != null) {
      this._addAccount(account);
    }
  }

  Future<void> removeAccount(int accountId) async {
    ApiOAuthModelAccount? account =
        await _apiAuthService.getAccountById(accountId);
    if (account != null) {
      ApiOAuthInterfaceProvider? provider =
          _apiAuthService.getProvider(account);
      if (provider != null) await provider.logOut(account);
      _accounts.removeWhere((account) => account.accountId == accountId);
      notifyListeners();
    }
  }

  Future<List<InfoCarouselCardModel>> getInfoCards(int accountId) async {
    List<ApiOAuthModelAccount> accounts =
        _accounts.where((account) => account.accountId == accountId).toList();
    if (accounts.isNotEmpty) {
      ApiOAuthModelAccount account = accounts[0];
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
    return _accounts.where((account) => account.provider == provider).toList();
  }

  void _addAccount(ApiOAuthModelAccount account) {
    ApiOAuthInterfaceProvider? providerService =
        _apiAuthService.getProvider(account);
    if (providerService != null) {
      providerService.logIn(account);
      _accounts.add(account);
      _dataBkgService.fetchData(account);
    }
    notifyListeners();
  }

  Future<void> _loadAccounts() async {
    _accounts = await _apiAuthService.getAllAccounts();
    notifyListeners();
  }
}
