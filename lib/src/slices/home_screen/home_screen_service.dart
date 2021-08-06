/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/home_screen/model/home_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/single_child_widget.dart';

import 'home_screen_controller.dart';
import 'home_screen_presenter.dart';

class HomeScreenService extends ChangeNotifier {
  late final HomeScreenController controller;
  late final HomeScreenPresenter presenter;
  late final HomeScreenModel model;

  HomeScreenService(List<SingleChildWidget> providers) {
    controller = HomeScreenController(this);
    presenter = HomeScreenPresenter(this, providers);
    model = HomeScreenModel();
  }

  void setCurrentScreenIndex(int index) {
    this.model.currentScreenIndex = index;
    notifyListeners();
  }
}
