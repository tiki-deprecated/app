/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_save_dialog_copy/ui/keys_save_dialog_copy.dart';
import 'package:provider/provider.dart';

import 'keys_save_dialog_copy_service.dart';

class KeysSaveDialogCopyPresenter {
  final KeysSaveDialogCopyService service;
  final String email;
  final String combinedKey;

  KeysSaveDialogCopyPresenter(this.service,
      {required this.email, required this.combinedKey});

  ChangeNotifierProvider<KeysSaveDialogCopyService> render() {
    return ChangeNotifierProvider.value(
        value: service,
        child: KeysSaveDialogCopy(combinedKey: combinedKey, email: email));
  }
}
