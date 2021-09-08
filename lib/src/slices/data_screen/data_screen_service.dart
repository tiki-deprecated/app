/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  DataScreenService(this._dataBkgService) {
    model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
  }

  Future<void> removeGoogleAccount() async {
    await _dataBkgService.removeGoogleAccount();
    this.model.googleAccount = null;
    notifyListeners();
  }

  Future<void> addGoogleAccount() async {
    this.model.googleAccount = await _dataBkgService.linkAccount('google');
    if (this.model.googleAccount != null) {
      _dataBkgService.checkGmail(fetchAll: true, force: true);
    }
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>> getGmailCards() async {
    return await _dataBkgService.gmailInfoCards();
  }

  Future<ApiAuthServiceAccountModel?> linkAccount(
      DataBkgProviderName provider, DataBkgProviderType type) async {
    ApiAuthServiceAccountModel? account;
    String? providerName = provider.value;
    if (providerName != null) {
      AuthorizationTokenResponse? tokenResponse = await _apiAuthService
          .authorizeAndExchangeCode(providerName: providerName);
      if (tokenResponse != null) {
        ApiAuthServiceAccountModel apiAuthServiceAccountModel =
            ApiAuthServiceAccountModel(
                provider: providerName,
                accessToken: tokenResponse.accessToken,
                accessTokenExpiration: tokenResponse
                    .accessTokenExpirationDateTime?.millisecondsSinceEpoch,
                refreshToken: tokenResponse.refreshToken,
                shouldReconnect: 0);
        Map? userInfo =
            await _apiAuthService.getUserInfo(apiAuthServiceAccountModel);
        if (userInfo != null) {
          apiAuthServiceAccountModel.displayName = userInfo['name'];
          apiAuthServiceAccountModel.username = userInfo['id'];
          apiAuthServiceAccountModel.email = userInfo['email'];
          account = await _apiAuthService.upsert(apiAuthServiceAccountModel);
          return account;
        }
      }
    }
    return null;
  }
}
