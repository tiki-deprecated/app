/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import '../api_zendesk/api_zendesk_service.dart';
import 'keys_modal_controller.dart';
import 'keys_modal_presenter.dart';
import 'model/keys_modal_model.dart';

class KeysModalService extends ChangeNotifier {
  late final KeysModalPresenter presenter;
  late final KeysModalController controller;
  late final KeysModalModel model;
  final ApiZendeskService zendeskService = ApiZendeskService();

  KeysModalService() {
    this.presenter = KeysModalPresenter(this);
    this.controller = KeysModalController(this);
    this.model = KeysModalModel();
  }
}
