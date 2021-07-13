/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen_service.dart';
import 'ui/home_screen_layout.dart';

class HomeScreenPresenter extends Page {
  final HomeScreenService service;

  HomeScreenPresenter(this.service) : super(key: ValueKey("HomeNav"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service, child: HomeScreenLayout()));
  }
}
