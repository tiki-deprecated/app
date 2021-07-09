/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/app/model/app_model.dart';
import 'package:app/src/slices/home_navigator/home_navigator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: AppModel.title,
          home: Navigator(
            pages: [
              HomeNavigatorService().getUI(), // TODO add login flow
            ],
            onPopPage: (_, __) => false, // TODO fix pop handling
          ),
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
