/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keys_save_dialog_copy_service.dart';
import 'ui/keys_save_dialog_copy_layout.dart';

class KeysSaveDialogCopyPresenter {
  final KeysSaveDialogCopyService service;
  final String email;
  final String combinedKey;

  KeysSaveDialogCopyPresenter(this.service,
      {required this.email, required this.combinedKey});

  Future show(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service,
            child: KeysSaveDialogCopyLayout(
                combinedKey: combinedKey, email: email)));
  }
}
