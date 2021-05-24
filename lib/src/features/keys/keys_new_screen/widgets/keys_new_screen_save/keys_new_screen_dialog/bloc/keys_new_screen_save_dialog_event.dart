/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_save_dialog_bloc.dart';

abstract class KeysNewScreenSaveDialogCopyEvent {
  const KeysNewScreenSaveDialogCopyEvent();
}

class KeysNewScreenCopied extends KeysNewScreenSaveDialogCopyEvent {
  const KeysNewScreenCopied() : super();
}
