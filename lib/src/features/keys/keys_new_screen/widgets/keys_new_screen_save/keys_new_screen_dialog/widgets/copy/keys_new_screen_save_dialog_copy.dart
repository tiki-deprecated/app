/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../keys_new_screen_save_dialog.dart';
import 'keys_new_screen_save_dialog_copy_button.dart';

class KeysNewScreenSaveDialogCopy extends KeysNewScreenSaveDialog{
  final RepoLocalSsCurrentModel currentModel;
  final String combinedKey;
  final Function copyCallback;

  KeysNewScreenSaveDialogCopy(this.combinedKey, this.currentModel, this.copyCallback) : super();

  @override
  String getTitle() =>  "Save securely to a pass manager";

  @override
  String getSubtitle() => 'Copy/paste your details manually to save your key to your pass manager.';

  @override
  Widget getContainer() => Container(
        child: Column(children: [
          Text(
            'YOUR ACCOUNT E-MAIL AND KEY',
            style: TextStyle(color: Colors.grey),
          ),
          KeysNewScreenSaveCopyButton(currentModel.email, copyCallback),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          KeysNewScreenSaveCopyButton(combinedKey, copyCallback),
        ]));

  @override
  String getButtonText() => 'Continue';

  @override
  Function getButtonAction() => Navigator.pop;

  @override
  bool isButtonActive() => true;


}
