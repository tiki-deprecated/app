/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlatformPageRoute {
  static Route<T> screen<T>(
    Widget destination, {
    RouteSettings? settings,
    String? title,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    if (Platform.isIOS)
      return CupertinoPageRoute(
          builder: (context) => destination,
          settings: settings,
          title: title,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog);
    else
      return MaterialPageRoute(
          builder: (context) => destination,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog);
  }
}
