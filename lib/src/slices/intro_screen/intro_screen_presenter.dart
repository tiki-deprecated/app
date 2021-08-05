/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intro_screen_service.dart';
import 'ui/intro_screen_layout.dart';

class IntroScreenPresenter extends Page {
  final IntroScreenService service;

  IntroScreenPresenter(this.service) : super(key: ValueKey("IntroScreen"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) =>
            ChangeNotifierProvider.value(value: service, child: IntroScreen()));
  }
}
