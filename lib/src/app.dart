/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_navigate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'provide.dart';

class App extends StatelessWidget {
  static const _title = 'TIKI';
  static const _nunitoSans = 'NunitoSans';

  @override
  Widget build(BuildContext context) =>
      Provide.chain(Platform.isIOS ? iosApp(context) : androidApp(context));

  MaterialApp androidApp(BuildContext context) {
    return MaterialApp(
        title: _title,
        routes: ConfigNavigate.routeTable(context),
        navigatorKey: ConfigNavigate.key,
        theme: ThemeData(
            fontFamily: _nunitoSans,
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: ConfigColor.mardiGras,
                displayColor: ConfigColor.mardiGras)));
  }

  CupertinoApp iosApp(BuildContext context) {
    return CupertinoApp(
        title: _title,
        routes: ConfigNavigate.routeTable(context),
        navigatorKey: ConfigNavigate.key,
        theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                    color: ConfigColor.mardiGras, fontFamily: _nunitoSans))));
  }
}
