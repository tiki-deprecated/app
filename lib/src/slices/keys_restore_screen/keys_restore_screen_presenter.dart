/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keys_restore_screen_service.dart';
import 'ui/keys_restore_screen_layout.dart';

class KeysRestoreScreenPresenter {
  final KeysRestoreScreenService service;

  KeysRestoreScreenPresenter(this.service);

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service, child: KeysRestoreScreenLayout()));
  }
}
