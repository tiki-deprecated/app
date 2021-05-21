/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_download/widgets/keys_new_screen_download_qr.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_save/keys_new_screen_dialog/bloc/keys_new_screen_save_dialog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../keys_new_screen_save_dialog.dart';

class KeysNewScreenSaveDialogDownload extends KeysNewScreenSaveDialog{

  final GlobalKey? repaintKey;
  final String dataKey;
  final Function? printCallback;

  KeysNewScreenSaveDialogDownload(this.dataKey, {this.repaintKey, this.printCallback }) : super();

  @override
  String getTitle() =>  "Save securely to a pass manager";

  @override
  String getSubtitle() => 'Copy/paste your details manually to save your key to your pass manager.';

  @override
  Widget getContainer() => KeysNewScreenQr(dataKey, printCallback);


  @override
  GlobalKey? getKey() => this.repaintKey;

  @override
  String getButtonText() => 'Continue';

  @override
  Function getButtonAction() => Navigator.pop;

  @override
  bool isButtonActive() => true;


}
