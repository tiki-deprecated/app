/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:google_provider/google_provider.dart';
import 'package:microsoft_provider/microsoft_provider.dart';
import 'package:spam_cards/spam_cards.dart';

import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_service.dart';
import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  late final DataScreenModel _model;
  late final DataScreenPresenter presenter;
  late final DataScreenController controller;
  final DataFetchService _dataFetchService;
  final ApiOAuthService _apiAuthService;
  final SpamCards _spamCards;

  get account => _model.account;

  DataScreenService(this._dataFetchService, this._apiAuthService, this._spamCards) {
    _model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);

    _apiAuthService.getAccount().then((account) {
      _model.account = account;
      if (account != null) _dataFetchService.asyncIndex(account);
      notifyListeners();
    });
  }

  Future<void> saveAccount(dynamic data, String provider) async {
    ApiOAuthModelAccount account = await _apiAuthService.save(data, provider);
    _model.account = account;
    _dataFetchService.asyncIndex(account);
    notifyListeners();
  }

  Future<void> removeAccount(String email, String provider) async {
    _apiAuthService.remove(email, provider);
    _model.account = null;
    notifyListeners();
  }

  fetchInbox(ApiOAuthModelAccount account) {
    _dataFetchService.asyncIndex(account, onFinishProcces: _addSpamCards);
    notifyListeners();
  }

  _addSpamCards(List messages) {
    _spamCards.addCards(
      provider: _model.account!.provider!,
      messages: messages,
      onUnsubscribe: _unsubscribeFromSpam,
      onKeep: _keepSender
    )
  }

  _unsubscribeFromSpam(int senderId) {
    switch(_model.account!.provider){
      case('google') :
        GoogleProvider.loggedIn(
            email: email,
            token: token
        ).sendEmail(to: to);
        break;
      case('microsoft') :
        MicrosoftProvider.loggedIn(
            email: email,
            token: token
        ).sendEmail(to: to);
        break;
    }
  }

  _keepSender(int senderId) {
  }
}
