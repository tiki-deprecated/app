/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/data_screen/data_screen_service.dart';
import 'package:app/src/slices/data_screen/ui/data_screen_layout.dart';
import 'package:provider/provider.dart';

class DataScreenPresenter {
  final DataScreenService service;

  DataScreenPresenter(this.service);

  ChangeNotifierProvider<DataScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: DataScreenLayout());
  }
}
