/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'keys_new_screen_save_dialog_copy_button.dart';

class KeysNewScreenSaveDialogCopy extends StatelessWidget {
  static const String _title = "Copy & Paste";
  static const String _subtitle =
      "the security keys below into your password manager.";
  final String _id = "TIKI ID";
  final String _dataKey = "DATA KEY";
  final String _signKey = "SIGN KEY";

  static final double _marginVerticalText =
      1 * PlatformRelativeSize.blockVertical;
  static final double _marginTopCopy = 1 * PlatformRelativeSize.blockVertical;

  final String id;
  final String dataKey;
  final String signKey;

  KeysNewScreenSaveDialogCopy(this.id, this.dataKey, this.signKey);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return _ios(context);
    else
      return _android(context);
  }

  AlertDialog _android(BuildContext context) {
    return AlertDialog(title: Text(_title), content: _content());
  }

  CupertinoAlertDialog _ios(BuildContext context) {
    return CupertinoAlertDialog(title: Text(_title), content: _content());
  }

  Widget _content() {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: _marginVerticalText),
        child: Text(_subtitle),
      ),
      Container(
        margin: EdgeInsets.only(top: _marginTopCopy),
        child: KeysNewScreenSaveCopyButton(_id, id),
      ),
      Container(
        margin: EdgeInsets.only(top: _marginTopCopy),
        child: KeysNewScreenSaveCopyButton(_dataKey, dataKey),
      ),
      Container(
        margin: EdgeInsets.only(top: _marginTopCopy),
        child: KeysNewScreenSaveCopyButton(_signKey, signKey),
      )
    ]);
  }
}
