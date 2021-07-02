/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_save_dialog_copy/model/keys_save_dialog_copy_model.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'keys_save_dialog_copy_controller.dart';
import 'keys_save_dialog_copy_presenter.dart';

class KeysSaveDialogCopyService extends ChangeNotifier {
  late KeysSaveDialogCopyPresenter presenter;
  late KeysSaveDialogCopyController controller;
  late KeysSaveDialogCopyModel model;

  final KeysSaveScreenService? keysSaveScreenService;

  KeysSaveDialogCopyService(
      {required String combinedKey,
      required String email,
      this.keysSaveScreenService}) {
    presenter = KeysSaveDialogCopyPresenter(this,
        combinedKey: combinedKey, email: email);
    controller = KeysSaveDialogCopyController();
    model = KeysSaveDialogCopyModel();
    if (keysSaveScreenService?.model.saved != null) {
      model.isCopiedKey = true;
      model.isCopiedEmail = true;
    }
  }

  getUI() {
    return presenter.render();
  }

  emailCopied() {
    model.isCopiedEmail = true;
    notifyListeners();
  }

  keyCopied() {
    model.isCopiedKey = true;
    notifyListeners();
  }
}
