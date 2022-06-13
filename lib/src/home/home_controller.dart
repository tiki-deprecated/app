/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'home_service.dart';

class HomeController {
  final HomeService service;

  HomeController(this.service);

  void onNavTap(int index) => service.setCurrentScreenIndex(index);

}
