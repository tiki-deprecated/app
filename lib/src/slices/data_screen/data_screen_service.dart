/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  DataScreenService(this._dataBkgService) {
    model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
  }

  Future<void> removeAccount(int accountId) async {
    await _dataBkgService.removeAccount(accountId);
    notifyListeners();
  }

  Future<void> linkAccount(String provider) async {
    await _dataBkgService.linkAccount(provider);
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>> getGmailCards() async {
    return await ApiGoogleService.gmailInfoCards();
  }

  List<ApiAuthServiceAccountModel> getAccountList() {
    return _dataBkgService.getAccountList();
  }

  List<String> getProvidersList() {
    return _dataBkgService.getProvidersList();
  }

  List<ApiAuthServiceAccountModel?> getAccountsByProvider(String provider) {
    return _dataBkgService.getAccountsByProvider(provider);
  }
}
