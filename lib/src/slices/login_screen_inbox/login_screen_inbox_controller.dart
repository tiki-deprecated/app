/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'login_screen_inbox_service.dart';

class LoginScreenInboxController {
  final LoginScreenInboxService service;

  LoginScreenInboxController(this.service);

  back() => service.back();

  resend() async => await service.resendEmail();
}
