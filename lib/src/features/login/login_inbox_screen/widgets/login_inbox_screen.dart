/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_inbox_screen_back.dart';
import 'login_inbox_screen_resend.dart';
import 'login_inbox_screen_sent_to.dart';
import 'login_inbox_screen_title.dart';

class LoginInboxScreen extends StatelessWidget {
  static final double _marginTopTitle = 3 * PlatformRelativeSize.blockVertical;
  static final double _marginTopResend = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomResend =
      20 * PlatformRelativeSize.blockVertical;

  Widget _background() {
    return TikiBackground(
        backgroundColor: ConfigColor.serenade,
        topRight: HelperImage('login-email-blob-tr'),
        bottomLeft: HelperImage('login-email-blob-bl'));
  }

  // TODO add Expanded to image
  List<Widget> _foreground(BuildContext context) {
    return [
      LoginInboxScreenBack(),
      Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(
              horizontal: PlatformRelativeSize.marginHorizontal),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: _marginTopTitle),
              alignment: Alignment.centerLeft,
              child: LoginInboxScreenTitle(),
            ),
            Expanded(child: HelperImage("inbox-pineapple")),
            Container(
                alignment: Alignment.topLeft, child: LoginInboxScreenSentTo()),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    top: _marginTopResend, bottom: _marginBottomResend),
                child: LoginInboxScreenResend())
          ]))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TikiScaffold(
        background: _background() as TikiBackground?,
        foregroundChildren: _foreground(context));
  }
}
