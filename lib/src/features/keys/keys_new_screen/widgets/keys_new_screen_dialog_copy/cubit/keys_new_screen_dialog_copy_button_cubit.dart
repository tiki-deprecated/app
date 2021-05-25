/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'keys_new_screen_dialog_copy_button_state.dart';

class KeysNewScreenDialogCopyButtonCubit
    extends Cubit<KeysNewScreenDialogCopyButtonState> {
  KeysNewScreenDialogCopyButtonCubit()
      : super(KeysNewScreenDialogCopyButtonInitial());

  void copied(String s) {
    Clipboard.setData(new ClipboardData(text: s));
    emit(KeysNewScreenDialogCopyButtonSuccess());
  }
}
