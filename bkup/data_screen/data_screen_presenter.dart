/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import 'data_screen_service.dart';
import 'ui/data_screen_layout.dart';

class DataScreenPresenter {
  final DataScreenService service;

  DataScreenPresenter(this.service);

  ChangeNotifierProvider<DataScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: DataScreenLayout());
  }
}
