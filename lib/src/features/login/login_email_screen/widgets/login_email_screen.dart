/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/md_viewer/md_viewer.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
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
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCta = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginRightTitle =
      15 * PlatformRelativeSize.blockHorizontal;
  static final double _marginTopInput =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopButton = 4 * PlatformRelativeSize.blockVertical;

  static const String _title = "Hey, nice to see you here";
  static const String _subtitle = "Enter your email below to begin.";

  List<Widget> _foreground(BuildContext context) {
    return [
      Container(
          margin:
              EdgeInsets.only(top: _marginTopTitle, right: _marginRightTitle),
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
          child: LoginEmailScreenButton()),
      Container(
        margin: EdgeInsets.only(top: _marginTopButton),
        child: Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              GestureDetector(
                  child: Text("Terms of Service"),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MdViewer("TERMS")))),
              GestureDetector(
                  child: Text("Privacy Policy"),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MdViewer("PRIVACY")))),
            ])),
      ),
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
