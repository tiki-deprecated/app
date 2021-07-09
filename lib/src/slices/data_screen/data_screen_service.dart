/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import 'data_screen_controller.dart';
import 'data_screen_presenter.dart';
import 'model/data_screen_model.dart';

class DataScreenService extends ChangeNotifier {
  late DataScreenModel model;
  late DataScreenPresenter presenter;
  late DataScreenController controller;

  DataScreenService() {
    model = DataScreenModel();
    controller = DataScreenController();
    presenter = DataScreenPresenter(this);
  }

  Widget getUI() {
    return this.presenter.render();
  }
}
