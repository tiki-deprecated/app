/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import 'support_modal_controller.dart';
import 'support_modal_presenter.dart';

class SupportModalService extends ChangeNotifier {
  late final SupportModalPresenter presenter;
  late final SupportModalController controller;

  dynamic data;

  SupportModalService() {
    this.presenter = SupportModalPresenter(this);
    this.controller = SupportModalController(this);
  }
}
