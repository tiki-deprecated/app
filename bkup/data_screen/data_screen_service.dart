/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

//import 'package:app/src/slices/data_fetch/model/data_fetch_model_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_provider.dart';
import '../data_fetch/data_fetch_service.dart';
import '../info_carousel_card/model/info_carousel_card_model.dart';
import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  late final DataScreenModel _model;
  late final DataScreenPresenter presenter;
  late final DataScreenController controller;
  final DataFetchService _dataFetchService;
  final ApiOAuthService _apiAuthService;

  ApiEmailMsgService _apiEmailMsgService;

  ApiEmailSenderService _apiEmailSenderService;

  get account => _model.account;

  DataScreenService(this._dataFetchService, this._apiAuthService,
      this._apiEmailMsgService, this._apiEmailSenderService) {
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
      await _apiAuthService.signOut(account);
      DataFetchInterfaceProvider? provider = _apiAuthService
          .interfaceProviders[account.provider] as DataFetchInterfaceProvider?;
      if (provider?.email != null) {
        // TODO
        // await _deleteMessages(account);
        // await _dataFetchService.email.deleteApiAppData(account);
      }
    }
    _model.account = null;
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>> getInfoCards(int accountId) async {
    ApiOAuthModelAccount? account = _model.account;
    if (account != null) {
      DataFetchInterfaceProvider? provider = _apiAuthService
          .interfaceProviders[account.provider] as DataFetchInterfaceProvider?;
      if (provider?.email != null) return await provider!.getInfoCards(account);
    }
    return List<InfoCarouselCardModel>.empty();
  }
}
