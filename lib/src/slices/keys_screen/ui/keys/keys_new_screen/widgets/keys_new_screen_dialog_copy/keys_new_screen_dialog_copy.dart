/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_dialog_copy/bloc/keys_new_screen_dialog_copy_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_dialog_copy/widgets/keys_new_screen_dialog_copy_button.dart';
import 'package:app/src/features/repo/repo_local_ss_current/app_model_current.dart';
import 'package:sizer/sizer.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeysNewScreenDialogCopy {
  static final double _marginBottomButton =
      4.h;
  static final double _marginVerticalField =
      0.75.h;
  static final double _marginVerticalCopy =
      4.h;

  AlertDialog alert(KeysNewScreenDialogCopyBloc bloc, String combinedKey,
      RepoLocalSsCurrentModel currentModel) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: _title(),
      content: _content(bloc, combinedKey, currentModel),
    );
  }

  Widget _title() {
    return TikiTitle("Save securely to a pass manager", fontSize: 9);
  }

  Widget _content(KeysNewScreenDialogCopyBloc bloc, String combinedKey,
      RepoLocalSsCurrentModel currentModel) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      TikiSubtitle(
        'Copy/paste your details manually to save your key to your pass manager.',
        fontWeight: FontWeight.normal,
        fontSize: 4.5.w,
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: _marginVerticalCopy),
        child: Column(
          children: [
            Text(
              'YOUR ACCOUNT E-MAIL AND KEY',
              style: TextStyle(
                  color: ConfigColor.gray, fontWeight: FontWeight.bold),
            ),
            KeysNewScreenDialogCopyButton(currentModel.email,
                () => bloc.add(KeysNewScreenDialogEmailCopied())),
            Padding(
                padding: EdgeInsets.symmetric(vertical: _marginVerticalField)),
            KeysNewScreenDialogCopyButton(
                combinedKey, () => bloc.add(KeysNewScreenDialogKeyCopied())),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.only(bottom: _marginBottomButton),
          child: TikiBigButton(
              'CONTINUE', true, (context) => Navigator.of(context).pop()))
    ]));
  }
}
