/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/security_score_modal/security_score_modal_controller.dart';
import 'package:flutter/widgets.dart';

import 'model/security_score_modal_model.dart';
import 'security_score_modal_presenter.dart';

class SecurityScoreModalService extends ChangeNotifier {
  late final SecurityScoreModalModel model;
  late final SecurityScoreModalPresenter presenter;
  late final SecurityScoreModalController controller;

  SecurityScoreModalService(
      {double? hacking, double? sensitivity, double? security}) {
    this.presenter = SecurityScoreModalPresenter(this);
    this.controller = SecurityScoreModalController(this);
    this.model = SecurityScoreModalModel(
        hacking: hacking, sensitivity: sensitivity, security: security);
  }
}
