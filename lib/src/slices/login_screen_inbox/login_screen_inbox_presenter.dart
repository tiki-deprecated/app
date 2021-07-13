/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen_inbox_service.dart';
import 'ui/login_screen_inbox_layout.dart';

class LoginScreenInboxPresenter extends Page {
  final LoginScreenInboxService service;

  LoginScreenInboxPresenter(this.service)
      : super(key: ValueKey("LoginScreenInbox"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service, child: LoginScreenInboxLayout()));
  }
}
