/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/utils/helper/helper_log_in.dart';
import 'package:app/src/widgets/tiki_card/tiki_card_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'config/config_color.dart';
import 'config/config_navigate.dart';
import 'provide.dart';
import 'utils/helper/helper_image.dart';
import 'widgets/tiki_card/tiki_card.dart';
import 'widgets/tiki_card/tiki_card_figure.dart';
import 'widgets/tiki_card/tiki_card_text.dart';

class App extends StatelessWidget {
  static const _title = 'TIKI';
  static const _nunitoSans = 'NunitoSans';
  final HelperLogIn _helperIsLoggedIn;

  App(this._helperIsLoggedIn);

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black,
        body:Center(
    child: TikiCard(
      TikiCardTitle(
          title: "Coming Next",
      ),
      TikiCardText("TIKI’s next release:\nadd your Gmail account"),
      TikiCardFigure(HelperImage("home-pineapple")))
    ))
  ); /*
      Provide.chain(Platform.isIOS ? iosApp(context) : androidApp(context));

  MaterialApp androidApp(BuildContext context) {
    return MaterialApp(
        title: _title,
        routes: ConfigNavigate.routeTable(context, _helperIsLoggedIn),
        navigatorKey: ConfigNavigate.key,
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: _nunitoSans,
                bodyColor: ConfigColor.mardiGras,
                displayColor: ConfigColor.mardiGras)));
  }

  CupertinoApp iosApp(BuildContext context) {
    return CupertinoApp(
        title: _title,
        routes: ConfigNavigate.routeTable(context, _helperIsLoggedIn),
        navigatorKey: ConfigNavigate.key,
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                    color: ConfigColor.mardiGras, fontFamily: _nunitoSans))));
  }*/
}
