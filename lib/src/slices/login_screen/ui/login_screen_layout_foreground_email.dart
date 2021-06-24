/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import 'login_screen_view_button.dart';
import 'login_screen_view_error.dart';
import 'login_screen_view_input.dart';
import 'login_screen_view_subtitle.dart';
import 'login_screen_view_title.dart';
import 'loginl_screen_view_tos.dart';

class LoginScreenForegroundEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      LoginScreenViewTitle(),
      LoginScreenViewSubtitle(),
      LoginScreenViewInput(),
      LoginScreenViewError(),
      LoginScreenViewButton(),
      LoginScreenViewTos(),
    ])));
  }
}
