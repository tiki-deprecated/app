/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_download/keys_new_screen_download.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../keys_new_screen_save_dialog.dart';

class KeysNewScreenSaveDialogDownload extends KeysNewScreenSaveDialog{
  final RepoLocalSsCurrentModel currentModel;
  final String combinedKey;

  KeysNewScreenSaveDialogDownload(this.combinedKey, this.currentModel) : super();

  @override
  String getTitle() =>  "Save securely to a pass manager";

  @override
  String getSubtitle() => 'Copy/paste your details manually to save your key to your pass manager.';

  @override
  Widget getContainer() => KeysNewScreenDownload();

  @override
  String getButtonText() => 'Continue';

  @override
  Function getButtonAction() => Navigator.pop;

  @override
  bool isButtonActive() => true;


}
