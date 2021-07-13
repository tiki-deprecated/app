/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_sentry.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'src/config/config_color.dart';
import 'src/config/config_font.dart';

class App extends StatelessWidget {
  static const String _title = "TIKI";

  final LoginFlowService loginFlowService;

  App(this.loginFlowService);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: _title,
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: ConfigFont.familyNunitoSans,
                bodyColor: ConfigColor.tikiBlue,
                displayColor: ConfigColor.tikiBlue)),
        home: Router(
            routerDelegate: loginFlowService.delegate,
            backButtonDispatcher: RootBackButtonDispatcher()),
        navigatorObservers: [ConfigSentry.navigatorObserver],
      );
    });
  }
}
