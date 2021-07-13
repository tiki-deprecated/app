/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/data_screen/ui/data_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataScreenPresenter extends Page {
  final DataScreenService service;

  DataScreenPresenter(this.service);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => ChangeNotifierProvider.value(
          value: service, child: DataScreenLayout()),
    );
  }
}
