/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';

import 'package:bloc/bloc.dart';

part 'keys_new_screen_save_dialog_event.dart';
part 'keys_new_screen_save_dialog_state.dart';

class KeysNewScreenSaveDialogCopyBloc extends Bloc<
    KeysNewScreenSaveDialogCopyEvent, KeysNewScreenSaveDialogCopyState> {
  KeysNewScreenSaveDialogCopyBloc.provide(context)
      : super(KeysNewScreenSaveDialogCopyInitial(context));

  @override
  Stream<KeysNewScreenSaveDialogCopyState> mapEventToState(
    KeysNewScreenSaveDialogCopyEvent event,
  ) async* {
    if (event is KeysNewScreenCopied) yield* _mapSaveDialogCopiedToState(event);
  }

  Stream<KeysNewScreenSaveDialogCopyState> _mapSaveDialogCopiedToState(
      KeysNewScreenCopied state) async* {
    yield KeysNewScreenSaveDialogCopied();
  }
}
