/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'data_screen_service.dart';

class DataScreenController {
  final DataScreenService service;

  DataScreenController(this.service);

  removeAccount(String email, String provider) =>
      service.removeAccount(email, provider);

  saveAccount(dynamic data, String provider) =>
      service.saveAccount(data, provider);
}
