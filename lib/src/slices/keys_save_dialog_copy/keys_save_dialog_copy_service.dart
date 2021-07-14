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

  final KeysSaveScreenService keysSaveScreenService;

  KeysSaveDialogCopyService(
      {required String combinedKey,
      required String email,
      required this.keysSaveScreenService}) {
    presenter = KeysSaveDialogCopyPresenter(this,
        combinedKey: combinedKey, email: email);
    controller = KeysSaveDialogCopyController();
    model = KeysSaveDialogCopyModel();
    if (keysSaveScreenService.model.saved) {
      model.isCopiedKey = true;
      model.isCopiedEmail = true;
    }
  }

  emailCopied() {
    model.isCopiedEmail = true;
    checkKeysScreen();
    notifyListeners();
  }

  keyCopied() {
    model.isCopiedKey = true;
    checkKeysScreen();
    notifyListeners();
  }

  void checkKeysScreen() {
    if (model.isCopiedKey) {
      keysSaveScreenService.model.saved = true;
      keysSaveScreenService.notifyListeners();
    }
  }
}
