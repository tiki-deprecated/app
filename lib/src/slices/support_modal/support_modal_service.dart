/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_zendesk/model/api_zendesk_category.dart';
import 'package:flutter/widgets.dart';

import 'support_modal_controller.dart';
import 'support_modal_presenter.dart';

class SupportModalService extends ChangeNotifier {
  late final SupportModalPresenter presenter;
  late final SupportModalController controller;

  dynamic data = [
    ApiZendeskCategory.fromMap({
      'id' : 1,
      'title' : 'test',
      'description' : 'test'
    })
  ];

  SupportModalService() {
    this.presenter = SupportModalPresenter(this);
    this.controller = SupportModalController(this);
  }
}
