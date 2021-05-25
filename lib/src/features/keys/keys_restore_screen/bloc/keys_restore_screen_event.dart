/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_restore_screen_bloc.dart';

abstract class KeysRestoreScreenEvent extends Equatable {
  const KeysRestoreScreenEvent();

  @override
  List<Object> get props => [];
}

class KeysRestoreScreenScanned extends KeysRestoreScreenEvent {
  const KeysRestoreScreenScanned() : super();
}

class KeysRestoreScreenKeyUpdated extends KeysRestoreScreenEvent {
  final String key;

  const KeysRestoreScreenKeyUpdated(this.key) : super();

  @override
  List<Object> get props => [key];
}

class KeysRestoreScreenSubmitted extends KeysRestoreScreenEvent {
  const KeysRestoreScreenSubmitted() : super();
}
