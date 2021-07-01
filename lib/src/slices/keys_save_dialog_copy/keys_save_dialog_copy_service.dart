/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_save_dialog_copy/model/keys_save_dialog_copy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'keys_save_dialog_copy_controller.dart';
import 'keys_save_dialog_copy_presenter.dart';

class KeysSaveDialogCopyService extends ChangeNotifier {
  late KeysSaveDialogCopyPresenter presenter;
  late KeysSaveDialogCopyController controller;
  late KeysSaveDialogCopyModel model;

  KeysSaveDialogCopyService(
      {required String combinedKey, required String email}) {
    presenter = KeysSaveDialogCopyPresenter(this,
        combinedKey: combinedKey, email: email);
    controller = KeysSaveDialogCopyController();
    model = KeysSaveDialogCopyModel();
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

  bool canContinue() {
    return model.isCopiedKey;
  }
}
