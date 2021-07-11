/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/google/google_service.dart';
import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  late DataScreenModel model;
  late DataScreenPresenter presenter;
  late DataScreenController controller;

  GoogleService googleService = GoogleService();

  DataScreenService() {
    model = DataScreenModel();
    controller = DataScreenController(this);
    presenter = DataScreenPresenter(this);
    initializeGoogleRepo();
  }

  Widget getUI() {
    return this.presenter.render();
  }

  initializeGoogleRepo() async {
    googleService = GoogleService();
    this.model.googleAccount = await googleService.getConnectedUser();
    notifyListeners();
  }

  void removeGoogleAccount() async {
    await googleService.signOut();
    this.model.googleAccount = null;
    notifyListeners();
  }

  void addGoogleAccount() async {
    this.model.googleAccount = await googleService.signIn();
    notifyListeners();
  }

  Future<List<InfoCarouselCardModel>> getGmailCards() async {
    return await googleService.getInfoCards();
  }
}
