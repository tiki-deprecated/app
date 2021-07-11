/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_layout.dart';
import 'package:provider/provider.dart';

class KeysRestoreScreenPresenter {
  final service;

  KeysRestoreScreenPresenter(this.service);

  ChangeNotifierProvider<KeysRestoreScreenService> render() {
    return ChangeNotifierProvider.value(
        value: service, child: KeysRestoreScreenLayout());
  }
}
