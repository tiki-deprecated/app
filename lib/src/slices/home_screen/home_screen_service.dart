/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:tiki_kv/tiki_kv.dart';

import '../home_screen/model/home_screen_model.dart';
import 'home_screen_controller.dart';
import 'home_screen_presenter.dart';
import 'model/home_screen_model_kv.dart';

class HomeScreenService extends ChangeNotifier {
  late final HomeScreenController controller;
  late final HomeScreenPresenter presenter;
  final HomeScreenModel model = HomeScreenModel();

  HomeScreenService() {
    controller = HomeScreenController(this);
    presenter = HomeScreenPresenter(this);
  }

  void setCurrentScreenIndex(int index) {
    model.currentScreenIndex = index;
    notifyListeners();
  }

  Future<void> showOverlay(TikiKv tikiKv) async {
    model.showOverlay =
        (await tikiKv.read(HomeScreenKv.decisionOverlayShown.name))?.value ==
            "false";
    notifyListeners();
  }

  Future<void> dismissOverlay(TikiKv tikiKv) async {
    await tikiKv.upsert(HomeScreenKv.decisionOverlayShown.name, "true");
    model.showOverlay = false;
    notifyListeners();
  }
}
