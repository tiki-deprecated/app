/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/utils/platform/platform_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_inbox_screen_back.dart';
import 'login_inbox_screen_resend.dart';
import 'login_inbox_screen_sent_to.dart';
import 'login_inbox_screen_title.dart';

class LoginInboxScreen extends PlatformScaffold {
  static final double _marginTopBack = 4.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopTitle = 3 * PlatformRelativeSize.blockVertical;
  static final double _marginTopResend = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomResend =
      20 * PlatformRelativeSize.blockVertical;

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: _screen(context));
  }

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: _screen(context));
  }

  Widget _screen(BuildContext context) {
    return Stack(
      children: [_background(), _foreground(context)],
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          color: ConfigColor.serenade,
        ),
        Container(
            alignment: Alignment.topRight,
            child: HelperImage('login-email-blob-tr')),
        Container(
            alignment: Alignment.bottomLeft,
            child: HelperImage('login-email-blob-bl')),
      ],
    );
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal),
              child: Column(children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: _marginTopBack),
                    child: LoginInboxScreenBack()),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: PlatformRelativeSize.marginHorizontal),
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.only(top: _marginTopTitle),
                            alignment: Alignment.centerLeft,
                            child: LoginInboxScreenTitle(),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: HelperImage("inbox-pineapple"))),
                          Container(
                              alignment: Alignment.topLeft,
                              child: LoginInboxScreenSentTo()),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                  top: _marginTopResend,
                                  bottom: _marginBottomResend),
                              child: LoginInboxScreenResend())
                        ])))
              ])))
    ]);
  }
}
