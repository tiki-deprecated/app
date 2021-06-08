/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper/helper_log_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'config/config_color.dart';
import 'config/config_navigate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'provide.dart';

class App extends StatelessWidget {
  static const _title = 'TIKI';
  static const _nunitoSans = 'NunitoSans';
  final HelperLogIn _helperIsLoggedIn;

  App(this._helperIsLoggedIn);

  @override
  Widget build(BuildContext context) => Provide.chain(MaterialApp(
      title: _title,
      routes: ConfigNavigate.routeTable(context, _helperIsLoggedIn),
      navigatorKey: ConfigNavigate.key,
      localizationsDelegates: [
        AppLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: _nunitoSans,
              bodyColor: ConfigColor.mardiGras,
              displayColor: ConfigColor.mardiGras))));
}
