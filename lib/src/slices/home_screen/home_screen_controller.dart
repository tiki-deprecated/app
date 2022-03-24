/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:tiki_kv/tiki_kv.dart';

import 'home_screen_service.dart';

class HomeScreenController {
  final HomeScreenService service;

  HomeScreenController(this.service);

  void onNavTap(int index) => service.setCurrentScreenIndex(index);

  Future<void> dismissOverlay(TikiKv tikiKv) async =>
      service.dismissOverlay(tikiKv);
}
