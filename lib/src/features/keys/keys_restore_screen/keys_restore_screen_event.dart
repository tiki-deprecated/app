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

class KeysRestoreScreenIdUpdated extends KeysRestoreScreenEvent {
  final String id;

  const KeysRestoreScreenIdUpdated(this.id) : super();

  @override
  List<Object> get props => [id];
}

class KeysRestoreScreenDataKeyUpdated extends KeysRestoreScreenEvent {
  final String dataKey;

  const KeysRestoreScreenDataKeyUpdated(this.dataKey) : super();

  @override
  List<Object> get props => [dataKey];
}

class KeysRestoreScreenSignKeyUpdated extends KeysRestoreScreenEvent {
  final String signKey;

  const KeysRestoreScreenSignKeyUpdated(this.signKey) : super();

  @override
  List<Object> get props => [signKey];
}

class KeysRestoreScreenSubmitted extends KeysRestoreScreenEvent {
  const KeysRestoreScreenSubmitted() : super();
}
