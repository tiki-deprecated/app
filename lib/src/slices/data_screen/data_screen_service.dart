/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  final ApiAppDataService appDataService;

  DataScreenService(
      this._googleService, this._dataBkgService, this.appDataService) {
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
    this.model.googleAccount = await _googleService.signIn();
    _dataBkgService.checkGmail(fetchAll: true, force: true);
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>> getGmailCards() async {
    return await _googleService.gmailInfoCards();
  }
}
