/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/md_viewer/md_viewer_service.dart';
import 'package:flutter/material.dart';

import 'login_screen_email_service.dart';

class LoginScreenEmailController {
  final LoginScreenEmailService service;

  LoginScreenEmailController(this.service);

  submitLogin() async => await service.submitEmail();

  emailChanged(BuildContext context, String input) =>
      service.onEmailChange(input);

  tos(BuildContext context) {
    Navigator.of(context)
        .push(MdViewerService("TERMS").presenter.createRoute(context));
  }

  privacy(BuildContext context) {
    Navigator.of(context)
        .push(MdViewerService("PRIVACY").presenter.createRoute(context));
  }
}
