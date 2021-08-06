/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'md_screen_service.dart';
import 'ui/md_screen_layout.dart';

class MdScreenPresenter {
  final MdScreenService service;

  MdScreenPresenter(this.service);

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service, child: MdScreenLayout()));
  }
}
