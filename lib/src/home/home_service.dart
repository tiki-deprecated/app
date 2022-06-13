/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'home_controller.dart';
import 'home_model.dart';
import 'home_model_overlay.dart';
import 'home_presenter.dart';

class HomeService extends ChangeNotifier {
  late final HomeController controller;
  late final HomePresenter presenter;
  final HomeModel model = HomeModel();

  HomeService() {
    controller = HomeController(this);
    presenter = HomePresenter(this);
  }

  void setCurrentScreenIndex(int index) {
    model.currentScreenIndex = index;
    notifyListeners();
  }

  Future<void> addOverlay(HomeModelOverlay overlay) async {
    model.overlay = overlay;
    notifyListeners();
  }

}
