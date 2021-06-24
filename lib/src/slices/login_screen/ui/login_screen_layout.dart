/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:app/src/slices/login_screen/ui/login_screen_foreground_inbox_.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'login_screen_layout_background.dart';
import 'login_screen_layout_foreground_email.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isSubmitted = Provider.of<LoginScreenService>(context).model.submitted;
    return Scaffold(
        body: Center(
            child: Stack(children: [
      LoginScreenBackground(),
      isSubmitted ? LoginScreenForegroundInbox() : LoginScreenForegroundEmail()
    ])));
  }
}
