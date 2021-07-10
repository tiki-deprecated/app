/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model.dart';
import 'package:app/src/slices/decision_cards/decision_cards_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<AppService>(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: AppModel.title,
          home: DecisionCardsService().getUI(), //service.home.getUI(),
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
