/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../home_screen/model/home_screen_model.dart';
import 'home_screen_controller.dart';
import 'home_screen_presenter.dart';

class HomeScreenService extends ChangeNotifier {
  late final HomeScreenController controller;
  late final HomeScreenPresenter presenter;
  final HomeScreenModel model = HomeScreenModel();

  HomeScreenService() {
    controller = HomeScreenController(this);
    presenter = HomeScreenPresenter(this);
  }

  void setCurrentScreenIndex(int index) {
    this.model.currentScreenIndex = index;
    notifyListeners();
  }

  Future<void> showOverlay(ApiAppDataService apiAppDataService) async {
    ApiAppDataModel? appData =
        await apiAppDataService.getByKey(ApiAppDataKey.decisionOverlayShown);
    if (appData == null || appData.value == "false") {
      model.showOverlay = true;
      notifyListeners();
    }
  }

  Future<void> dismissOverlay(ApiAppDataService apiAppDataService) async {
    await apiAppDataService.save(ApiAppDataKey.decisionOverlayShown, "true");
    model.showOverlay = false;
    notifyListeners();
  }
}
