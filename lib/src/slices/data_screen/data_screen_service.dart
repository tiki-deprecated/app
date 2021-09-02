/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_google/api_google_service.dart';
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
  final ApiGoogleService _googleService;
  final ApiAuthService _apiAuthService;

  DataScreenService(
      this._googleService, this._dataBkgService, this._apiAuthService) {
    model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
    initializeGoogleRepo();
  }

  Future<void> initializeGoogleRepo() async {
    this.model.googleAccount = await _googleService.getConnectedUser();
    notifyListeners();
  }

  Future<void> removeGoogleAccount() async {
    await _googleService.signOut();
    this.model.googleAccount = null;
    notifyListeners();
  }

  Future<void> addGoogleAccount() async {
    ApiAuthServiceAccountModel? account = await this.linkAccount('google');
    print(account);
    if (account != null) {
      // this.model.googleAccount = await _googleService.signIn();
      // _dataBkgService.checkGmail(fetchAll: true, force: true);
      // notifyListeners();
    }
  }

  Future<List<InfoCarouselCardModel>> getGmailCards() async {
    return await _googleService.gmailInfoCards();
  }

  Future<ApiAuthServiceAccountModel?> linkAccount(String providerName) async {
    ApiAuthServiceAccountModel? account;
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
      String? username =
          await _apiAuthService.getUsername(apiAuthServiceAccountModel);
      apiAuthServiceAccountModel.username = username;
      account = await _apiAuthService.upsert(apiAuthServiceAccountModel);
    }
    return account;
  }
}
