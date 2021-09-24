/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_flow/login_flow_service.dart';
import 'intro_screen_service.dart';

class IntroScreenController {
  final IntroScreenService service;

  IntroScreenController(this.service);

  void navigateToNextScreen(context) {
    if (!service.isLastCard()) {
      service.moveToNextScreen();
    } else {
      skipToLogin(context);
    }
  }

  void navigateToPreviousScreen(context) {
    if (!service.isFirstCard()) {
      service.moveToPreviousScreen();
    }
  }

  void skipToLogin(context) =>
      Provider.of<LoginFlowService>(context, listen: false).setReturningUser();

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0) navigateToNextScreen(context);
    if (dragEndDetails.primaryVelocity! > 0) navigateToPreviousScreen(context);
  }
}
