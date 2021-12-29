/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api_app_data/api_app_data_service.dart';
import 'home_screen_service.dart';

class HomeScreenController {
  final HomeScreenService service;

  HomeScreenController(this.service);

  void onNavTap(int index) => service.setCurrentScreenIndex(index);

  Future<void> dismissOverlay(BuildContext context) async {
    ApiAppDataService apiAppDataService =
        Provider.of<ApiAppDataService>(context, listen: false);
    return service.dismissOverlay(apiAppDataService);
  }
}
