/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'keys_save_dialog_dl_service.dart';
import 'ui/keys_save_dialog_dl_layout.dart';

class KeysSaveDialogDlPresenter {
  final KeysSaveDialogDlService service;
  final GlobalKey repaintKey;
  final String combinedKey;

  KeysSaveDialogDlPresenter(this.service,
      {required this.combinedKey, required this.repaintKey});

  Future show(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ChangeNotifierProvider.value(
            value: service,
            child: KeysSaveDialogDlLayout(
                combinedKey: combinedKey, repaintKey: repaintKey)));
  }
}
