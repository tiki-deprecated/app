/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'keys_new_screen_save_continue.dart';
import 'keys_new_screen_save_restore.dart';
import 'keys_new_screen_save_skip.dart';

class KeysNewScreenSave extends StatelessWidget {
  static final double _marginTopTitle = 10 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalSubtitle =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginBottomButton =
      5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopDownload =
      3 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalSkip =
      1 * PlatformRelativeSize.blockVertical;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal2x),
              child: SingleChildScrollView(
                  child: Column(children: [
                TikiTitle("Backup your account"),
                TikiSubtitle(
                    "We recommend you to securely save your key in case you change your device."),
                Card(child: Text("Save securely")),
                Card(child: Text("Download")),
                KeysNewScreenSaveContinue(),
                KeysNewScreenSaveSkip(),
                KeysNewScreenSaveRestore()
              ]))))
    ]);
  }
}
