/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_auth_service/model/api_auth_sv_email_interface.dart';
import '../api_auth_service/model/api_auth_sv_provider_interface.dart';
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

  late List<ApiAuthServiceAccountModel> _accounts = List.empty(growable: true);

  get accounts => _accounts;

  DataScreenService(this._dataBkgService, this._apiAuthService) {
    model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
    loadAccounts();
  }

  void addAccount(ApiAuthServiceAccountModel account) {
    ApiAuthServiceProviderInterface? providerService =
        _apiAuthService.getProvider(account);
    if (providerService != null) {
      providerService.logIn(account);
      _accounts.add(account);
      _dataBkgService.fetchData(account);
    }
    notifyListeners();
  }

  Future<void> loadAccounts() async {
    _accounts = await _apiAuthService.getAllAccounts();
    notifyListeners();
  }

  Future<void> removeAccount(int accountId) async {
    ApiAuthServiceAccountModel? account =
        await _apiAuthService.getAccountById(accountId);
    if (account != null) {
      ApiAuthServiceProviderInterface? provider =
          _apiAuthService.getProvider(account);
      if (provider != null) await provider.logOut(account);
      _accounts.removeWhere((account) => account.accountId == accountId);
      notifyListeners();
    }
  }

  Future<List<InfoCarouselCardModel>> getInfoCards(int accountId) async {
    List<ApiAuthServiceAccountModel> accounts =
        _accounts.where((account) => account.accountId == accountId).toList();
    if (accounts.isNotEmpty) {
      ApiAuthServiceAccountModel account = accounts[0];
      ApiAuthServiceEmailInterface provider =
          _apiAuthService.getProvider(account) as ApiAuthServiceEmailInterface;
      return await provider.getInfoCards(account);
    }
    return List<InfoCarouselCardModel>.empty();
  }

  List<ApiAuthServiceAccountModel> getAccountsByProvider(String provider) {
    return _accounts.where((account) => account.provider == provider).toList();
  }

  Future<void> linkAccount(String provider) async {
    ApiAuthServiceAccountModel? account =
        await _apiAuthService.linkAccount(provider);
    if (account != null) {
      this.addAccount(account);
    }
  }

  List<String> getProvidersList() {
    return _apiAuthService.getProviders();
  }
}
