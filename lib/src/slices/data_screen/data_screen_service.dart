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
    initializeGoogleRepo();
  }

  Future<void> initializeGoogleRepo() async {
    this.model.googleAccount = await _dataBkgService.getGoogleAccount();
    notifyListeners();
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
}
