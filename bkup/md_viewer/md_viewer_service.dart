/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'md_viewer_controller.dart';
import 'md_viewer_presenter.dart';
import 'model/md_viewer_model.dart';

class MdViewerService extends ChangeNotifier {
  late MdViewerModel model;
  late MdViewerPresenter presenter;
  late MdViewerController controller;

  MdViewerService(String filename) {
    model = MdViewerModel();
    model.filename = filename;
    controller = MdViewerController();
    presenter = MdViewerPresenter(this);
  }

  Widget getUI() {
    return this.presenter.render();
  }

  void setFile(String filename) {
    model.filename = filename;
    notifyListeners();
  }
}
