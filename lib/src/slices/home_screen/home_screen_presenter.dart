/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'home_screen_service.dart';
import 'ui/home_screen_layout.dart';

class HomeScreenPresenter extends Page {
  final HomeScreenService service;
  final List<SingleChildWidget> providers;

  HomeScreenPresenter({required this.service, List<SingleChildWidget>? providers})
      : this.providers = providers ?? [],
        super(key: ValueKey("HomeNav"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service,
            child: MultiProvider(
                providers: providers, child: HomeScreenLayout())));
  }
}
