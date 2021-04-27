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

class LoginInboxScreen extends PlatformScaffold {
  static final double _marginVerticalTitle =
      15 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalCta =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalImage =
      3.75 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalButton =
      7.5 * PlatformRelativeSize.blockVertical;

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
            child: Align(
                alignment: Alignment.topRight,
                child: HelperImage('login-email-blob-tr'))),
        Container(
            child: Align(
                alignment: Alignment.bottomLeft,
                child: HelperImage('login-email-blob-bl'))),
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
                /*Container(
                    margin: EdgeInsets.only(top: _marginVerticalTitle),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: UiLoginTitle())),
                Container(
                    margin: EdgeInsets.only(top: _marginVerticalCta),
                    child: Align(
                        alignment: Alignment.centerLeft, child: UiLoginCta())),
                Container(
                  margin: EdgeInsets.only(top: _marginVerticalImage),
                  child: HelperUiImage('login-email-pineapple'),
                ),
                Container(
                    margin: EdgeInsets.only(top: _marginVerticalButton),
                    child: HelperUiBigButton(ConfigString.loginEmail.button,
                        (BuildContext context) {
                      throw UnimplementedError();
                    }))*/
              ])))
    ]);
  }
}
