/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/keys_create_screen/keys_create_screen_service.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:app/src/slices/login_screen/ui/login_screen_layout_foreground_inbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'login_screen_layout_background_email.dart';
import 'login_screen_layout_background_inbox.dart';
import 'login_screen_layout_foreground_email.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appService = Provider.of<AppService>(context);
    var child = _loginWidget(context);
    if (appService.home is KeysCreateScreenService) {
      child = KeysCreateScreenService(appService).getUI();
    } else if (appService.home is KeysSaveScreenService) {
      child = KeysSaveScreenService().getUI();
    } else if (appService.home is KeysRestoreScreenService) {
      child = KeysRestoreScreenService(appService).getUI();
    } else if (appService.home is DataScreenService) {
      child = DataScreenService().getUI();
    }
    return child;
  }

  _loginWidget(BuildContext context) {
    var isSubmitted = Provider.of<LoginScreenService>(context).model.submitted;
    return Scaffold(
        body: Center(
            child: Stack(children: [
      isSubmitted ? LoginScreenBackgroundInbox() : LoginScreenBackgroundEmail(),
      isSubmitted ? LoginScreenForegroundInbox() : LoginScreenForegroundEmail()
    ])));
  }
}
