/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/login/login_email_screen/widgets/login_email_screen_tos.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:sizer/sizer.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_email_screen_button.dart';
import 'login_email_screen_error.dart';
import 'login_email_screen_input.dart';

class LoginEmailScreen extends StatelessWidget {
  static final double _marginTopTitle = 15.h;
  static final double _marginTopCta = 2.h;
  static final double _marginRightTitle =
      15.w;
  static final double _marginTopInput =
      2.5.h;
  static final double _marginTopButton = 4.h;
  static final double _marginTopTos = 2.h;

  static const String _title = "Hey, nice to see you here";
  static const String _subtitle = "Enter your email below to begin.";

  List<Widget> _foreground(BuildContext context) {
    return [
      Container(
          margin:
              EdgeInsets.only(top: _marginTopTitle, right: _marginRightTitle),
          alignment: Alignment.centerLeft,
          child: TikiTitle(
            _title,
            textAlign: TextAlign.left,
          )),
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
          child: LoginEmailScreenButton()),
      Container(
          margin: EdgeInsets.only(top: _marginTopTos),
          child: LoginEmailScreenTos()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    TikiBackground background = TikiBackground(
        backgroundColor: ConfigColor.serenade,
        topRight: HelperImage('login-pineapple'),
        centerLeft: HelperImage('login-blob'));

    return TikiScaffold(
      background: background,
      foregroundChildren: _foreground(context),
    );
  }
}
