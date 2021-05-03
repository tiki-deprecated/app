/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen_dialog/keys_new_screen_save_dialog_qr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'keys_new_screen_save_bk.dart';

class KeysNewScreenSaveBkQr extends KeysNewScreenSaveBk {
  static const String _title = "QR Code";
  static const String _text =
      "Show a QR code to manually screenshot or scan with another device/app";

  KeysNewScreenSaveBkQr() : super(_title, _text, "save-qr-icon");

  @override
  Future<void> onPressed(BuildContext context, KeysNewScreenState state) {
    BlocProvider.of<KeysNewScreenBloc>(context).add(KeysNewScreenBackedUp());
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return KeysNewScreenSaveDialogQr(
            state.address, state.dataPrivate, state.signPrivate);
      },
    );
  }
}
