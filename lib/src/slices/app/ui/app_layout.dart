/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<AppService>(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: AppModel.title,
          routes: {"/": (context) => service.home.getUI()},
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: AppModel.fontFamily,
                  bodyColor: AppModel.bodyColor,
                  displayColor: AppModel.displayColor)));
    });
  }
}
