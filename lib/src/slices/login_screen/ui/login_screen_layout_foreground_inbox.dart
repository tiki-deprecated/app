/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/login_screen/ui/login_screen_inbox_back_button.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import 'login_inbox_screen_resend.dart';
import 'login_inbox_screen_sent_to.dart';
import 'login_inbox_screen_title.dart';

class LoginScreenForegroundInbox extends StatelessWidget {
  Widget _background() {
    return TikiBackground(
        backgroundColor: ConfigColor.serenade,
        topRight: HelperImage('login-email-blob-tr'),
        bottomLeft: HelperImage('login-email-blob-bl'));
  }

  List<Widget> _foreground(BuildContext context) {
    return [
      LoginScreenInboxBackButton(),
      Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(children: [
            LoginInboxScreenTitle(),
            Expanded(child: HelperImage("inbox-pineapple")),
            LoginInboxScreenSentTo(),
            LoginInboxScreenResend()
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
