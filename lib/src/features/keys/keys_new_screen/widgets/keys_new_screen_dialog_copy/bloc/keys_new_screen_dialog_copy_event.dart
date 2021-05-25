/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_dialog_copy_bloc.dart';

abstract class KeysNewScreenDialogCopyEvent {
  const KeysNewScreenDialogCopyEvent();
}

class KeysNewScreenDialogEmailCopied extends KeysNewScreenDialogCopyEvent {
  const KeysNewScreenDialogEmailCopied() : super();
}

class KeysNewScreenDialogKeyCopied extends KeysNewScreenDialogCopyEvent {
  const KeysNewScreenDialogKeyCopied() : super();
}
