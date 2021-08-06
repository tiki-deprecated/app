/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'md_screen_controller.dart';
import 'md_screen_presenter.dart';
import 'model/md_screen_model.dart';

class MdScreenService extends ChangeNotifier {
  late final MdScreenModel model;
  late final MdScreenPresenter presenter;
  late final MdScreenController controller;

  MdScreenService(String filename) {
    model = MdScreenModel();
    model.filename = filename;
    presenter = MdScreenPresenter(this);
    controller = MdScreenController(this);
  }

  void setFile(String filename) {
    model.filename = filename;
    notifyListeners();
  }
}
