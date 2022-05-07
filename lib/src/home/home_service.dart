/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_kv/tiki_kv.dart';

import 'home_controller.dart';
import 'home_model.dart';
import 'home_presenter.dart';

class HomeService extends ChangeNotifier {
  static const String _decisionOverlayShown = 'decisionOverlayShown';
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

  Future<void> showOverlay(TikiKv tikiKv) async {
    model.showOverlay = (await tikiKv.read(_decisionOverlayShown)) == 'false';
    notifyListeners();
  }

  Future<void> dismissOverlay(TikiKv tikiKv) async {
    await tikiKv.upsert(_decisionOverlayShown, 'true');
    model.showOverlay = false;
    notifyListeners();
  }
}
