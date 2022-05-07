/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_kv/tiki_kv.dart';

import 'home_service.dart';

class HomeController {
  final HomeService service;

  HomeController(this.service);

  void onNavTap(int index) => service.setCurrentScreenIndex(index);

  Future<void> dismissOverlay(TikiKv tikiKv) async =>
      service.dismissOverlay(tikiKv);
}
