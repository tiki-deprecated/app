/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/app/app_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<AppService>(context, listen: false);
    var model = service.model;
    return MaterialApp(
        title: model.title,
        routes: service.getRoutes(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: model.fontFamily,
                bodyColor: model.bodyColor,
                displayColor: model.displayColor)));
  }
}
