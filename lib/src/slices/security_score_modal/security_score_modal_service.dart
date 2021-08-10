/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import 'model/security_score_modal_model.dart';
import 'security_score_modal_presenter.dart';

class SecurityScoreModalService extends ChangeNotifier {
  late final SecurityScoreModalModel model;
  late final SecurityScoreModalPresenter presenter;

  SecurityScoreModalService({double? hacking, double? sensitivity}) {
    this.presenter = SecurityScoreModalPresenter(this);
    this.model =
        SecurityScoreModalModel(hacking: hacking, sensitivity: sensitivity);
  }
}
