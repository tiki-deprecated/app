/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'support_screen_service.dart';
import 'ui/support_screen_page.dart';

class SupportScreenPresenter {
  final SupportScreenService service;

  SupportScreenPresenter(this.service);

  Page render() => SupportScreenPage(service);
}
