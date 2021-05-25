/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:bloc/bloc.dart';

part 'keys_new_screen_dialog_copy_event.dart';
part 'keys_new_screen_dialog_copy_state.dart';

class KeysNewScreenDialogCopyBloc
    extends Bloc<KeysNewScreenDialogCopyEvent, KeysNewScreenDialogCopyState> {
  KeysNewScreenDialogCopyBloc() : super(KeysNewScreenDialogCopyInitial());

  @override
  Stream<KeysNewScreenDialogCopyState> mapEventToState(
    KeysNewScreenDialogCopyEvent event,
  ) async* {
    if (event is KeysNewScreenDialogEmailCopied)
      yield* _mapEmailCopiedToState(event);
    else if (event is KeysNewScreenDialogKeyCopied)
      yield* _mapKeyCopiedToState(event);
  }

  Stream<KeysNewScreenDialogCopyState> _mapEmailCopiedToState(
      KeysNewScreenDialogEmailCopied state) async* {
    yield KeysNewScreenDialogCopySuccess(true, this.state.isKey);
  }

  Stream<KeysNewScreenDialogCopyState> _mapKeyCopiedToState(
      KeysNewScreenDialogKeyCopied state) async* {
    yield KeysNewScreenDialogCopySuccess(this.state.isKey, true);
  }
}
