/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import 'app_presenter.dart';

class AppService extends ChangeNotifier {
  late AppPresenter presenter;

  AppService() {
    this.presenter = AppPresenter(this);
  }

  Widget getUI() {
    return presenter.render();
  }
}
