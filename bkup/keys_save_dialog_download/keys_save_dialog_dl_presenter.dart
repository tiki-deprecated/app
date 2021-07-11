/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_save_dialog_download/ui/keys_save_dialog_dl_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'keys_save_dialog_dl_service.dart';

class KeysSaveDialogDlPresenter {
  final KeysSaveDialogDlService service;
  final GlobalKey repaintKey;
  final String combinedKey;

  KeysSaveDialogDlPresenter(this.service,
      {required this.combinedKey, required this.repaintKey});

  ChangeNotifierProvider<KeysSaveDialogDlService> render() {
    return ChangeNotifierProvider.value(
        value: service,
        child: KeysSaveDialogDlLayout(
            combinedKey: combinedKey, repaintKey: repaintKey));
  }
}
