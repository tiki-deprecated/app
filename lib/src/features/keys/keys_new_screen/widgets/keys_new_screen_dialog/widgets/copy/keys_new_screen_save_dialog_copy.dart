/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'keys_new_screen_save_dialog_copy_button.dart';

class KeysNewScreenSaveDialogCopy {
  final RepoLocalSsCurrentModel currentModel;

  final String combinedKey;

  KeysNewScreenSaveDialogCopy(this.combinedKey, this.currentModel);

  AlertDialog alert(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: TikiTitle("Save securely to a pass manager", fontSize: 9),
        content: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          TikiSubtitle(
            //'Press submit to save your key to your default pass manager or copy/paste your details manually.',
            'Copy/paste your details manually to save your key to your pass manager.',
            fontWeight: FontWeight.normal,
            fontSize: 4.5 * PlatformRelativeSize.blockHorizontal,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 16)),
          Container(
              child: Column(children: [
            Text(
              'YOUR ACCOUNT E-MAIL AND KEY',
              style: TextStyle(color: Colors.grey),
            ),
            KeysNewScreenSaveCopyButton(currentModel.email),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            KeysNewScreenSaveCopyButton(combinedKey),
          ])),
          Padding(padding: EdgeInsets.symmetric(vertical: 16)),
          TikiBigButton('Continue', true, Navigator.pop)
        ])));
  }
}
