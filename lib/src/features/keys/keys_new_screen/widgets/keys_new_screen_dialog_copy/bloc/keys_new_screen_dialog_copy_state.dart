/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_dialog_copy_bloc.dart';

abstract class KeysNewScreenDialogCopyState {
  final bool isEmail;
  final bool isKey;

  const KeysNewScreenDialogCopyState(this.isEmail, this.isKey);

  @override
  List<Object> get props => [isEmail, isKey];
}

class KeysNewScreenDialogCopyInitial extends KeysNewScreenDialogCopyState {
  const KeysNewScreenDialogCopyInitial() : super(false, false);
}

class KeysNewScreenDialogCopySuccess extends KeysNewScreenDialogCopyState {
  const KeysNewScreenDialogCopySuccess(bool isEmail, bool isKey)
      : super(isEmail, isKey);
}
