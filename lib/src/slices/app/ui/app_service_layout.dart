/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:app/src/slices/login_flow/login_flow_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class AppLayout extends StatelessWidget {
  static const String _title = "TIKI";

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      LoginFlowService loginFlowService = LoginFlowService();
      return MaterialApp.router(
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
        routerDelegate: loginFlowService.delegate,
        routeInformationParser: loginFlowService.informationParser,
      );
    });
  }
}
