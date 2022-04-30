/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'src/config/config_sentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';


class App extends StatelessWidget {
  static const String _title = "TIKI";
  final RouterDelegate _routerDelegate;

  const App(this._routerDelegate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: TextProvider.familyNunitoSans,
                bodyColor: ColorProvider.tikiBlue,
                displayColor: ColorProvider.tikiBlue)),
        home: Router(
            routerDelegate: _routerDelegate,
            backButtonDispatcher: RootBackButtonDispatcher()),
        navigatorObservers: [ConfigSentry.navigatorObserver],
      );
    }
  }
