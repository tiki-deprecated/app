/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'logout_modal_service.dart';

class LogoutModalController {
  final LogoutModalService service;

  LogoutModalController(this.service);

  void onLogout(BuildContext context) => service.login.logout();
}
