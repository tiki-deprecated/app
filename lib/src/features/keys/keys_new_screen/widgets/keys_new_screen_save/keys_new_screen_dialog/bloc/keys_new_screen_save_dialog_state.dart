/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_save_dialog_bloc.dart';

abstract class KeysNewScreenSaveDialogCopyState {
  const KeysNewScreenSaveDialogCopyState();
}

class KeysNewScreenSaveDialogCopyInitial
    extends KeysNewScreenSaveDialogCopyState {
  const KeysNewScreenSaveDialogCopyInitial(context) : super();
}

class KeysNewScreenSaveDialogCopied extends KeysNewScreenSaveDialogCopyState {
  const KeysNewScreenSaveDialogCopied() : super();
}
