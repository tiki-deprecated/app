/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'home_screen_service.dart';

class HomeScreenController {
  final HomeScreenService service;

  HomeScreenController(this.service);

  void onNavTap(int index) => service.setCurrentScreenIndex(index);
}
