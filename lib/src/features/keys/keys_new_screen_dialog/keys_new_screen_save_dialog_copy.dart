/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper/helper_log_in.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'keys_new_screen_save_dialog_copy_button.dart';

class KeysNewScreenSaveDialogCopy extends StatelessWidget {
  final String _dataKey = "DATA KEY";
  final String _email = "E-mail";

  final String? unifiedKey;

  KeysNewScreenSaveDialogCopy(this.unifiedKey);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: TikiTitle("Save securely to a pass manager", fontSize: 9),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TikiSubtitle(
            'Press submit to save your key to your default pass manager or copy/paste your details manually.',
            fontWeight: FontWeight.normal,
            fontSize: 4.5 * PlatformRelativeSize.blockHorizontal,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'YOUR ACCOUNT E-MAIL AND KEY',
                    style: TextStyle(color: Colors.grey),
                  ),
                  // TODO KeysNewScreenSaveCopyButton(_email, helperLogIn.current.email),
                  KeysNewScreenSaveCopyButton(_dataKey, unifiedKey),
                ],
              )
            ],
          ),
          TikiBigButton('Continue', true, () => {})
        ]));
  }
}
