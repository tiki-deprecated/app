/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keys_save_screen_service.dart';
import 'ui/keys_save_screen_layout.dart';

class KeysSaveScreenPresenter extends Page {
  final KeysSaveScreenService service;

  KeysSaveScreenPresenter(this.service)
      : super(key: ValueKey("KeysSaveScreen"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => ChangeNotifierProvider.value(
          value: service, child: KeysSaveScreenLayout()),
    );
  }
}
