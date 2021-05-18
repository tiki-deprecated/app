/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/login/login_otp_req/login_otp_req_bloc.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_title.dart';
import 'package:app/src/widgets/screens/foreground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_email_screen_button.dart';
import 'login_email_screen_error.dart';
import 'login_email_screen_input.dart';

class LoginEmailScreen extends StatelessWidget {
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCta = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginRightTitle =
      15 * PlatformRelativeSize.blockHorizontal;
  static final double _marginTopBlob = 46 * PlatformRelativeSize.blockVertical;
  static final double _marginTopInput =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopButton = 4 * PlatformRelativeSize.blockVertical;

  static const String _title = "Hey, nice to see you here";
  static const String _subtitle = "Enter your email below to begin.";

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConfigColor.serenade,
        ),
        Container(
            margin: EdgeInsets.only(top: _marginTopBlob),
            child: HelperImage('login-blob')),
        Container(
            alignment: Alignment.topRight,
            child: HelperImage('login-pineapple')),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return TikiForeground(children: [
                  Container(
                  margin: EdgeInsets.only(
                  top: _marginTopTitle, right: _marginRightTitle),
                  alignment: Alignment.centerLeft,
                  child: TikiTitle(_title)),
              Container(
                  margin: EdgeInsets.only(top: _marginTopCta),
                  alignment: Alignment.centerLeft,
                  child: TikiSubtitle(_subtitle, fontWeight: FontWeight.w600)),
              Container(
                  margin: EdgeInsets.only(top: _marginTopInput),
                  child: LoginEmailScreenInput(),
              ),
          LoginEmailScreenError(),
          Container(
              margin: EdgeInsets.only(top: _marginTopButton),
              child: LoginEmailScreenButton())
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [_background(), _foreground(context)],
        )
    );
  }
}
