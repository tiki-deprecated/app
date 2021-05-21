/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/keys/keys_new_screen/bloc/keys_new_screen_bloc.dart';
import 'package:app/src/features/keys/keys_new_screen/widgets/keys_new_screen_dialog/widgets/download/keys_new_screen_save_dialog_qr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@deprecated
class KeysNewScreenSaveBkQr {


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
