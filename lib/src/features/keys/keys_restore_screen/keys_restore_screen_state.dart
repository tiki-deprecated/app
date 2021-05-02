/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_restore_screen_bloc.dart';

abstract class KeysRestoreScreenState extends Equatable {
  final String dataPublic;
  final String dataPrivate;
  final String signPublic;
  final String signPrivate;
  final String address;

  const KeysRestoreScreenState(this.dataPublic, this.dataPrivate,
      this.signPublic, this.signPrivate, this.address);

  @override
  List<Object> get props =>
      [dataPublic, dataPrivate, signPublic, signPrivate, address];
}

class KeysRestoreScreenInitial extends KeysRestoreScreenState {
  const KeysRestoreScreenInitial() : super(null, null, null, null, null);
}

class KeysRestoreScreenInProgress extends KeysRestoreScreenState {
  final bool isValid;

  const KeysRestoreScreenInProgress(String dataPublic, String dataPrivate,
      String signPublic, String signPrivate, String address, this.isValid)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);

  @override
  List<Object> get props =>
      [dataPublic, dataPrivate, signPublic, signPrivate, address, this.isValid];
}

class KeysRestoreScreenSuccess extends KeysRestoreScreenState {
  const KeysRestoreScreenSuccess(String dataPublic, String dataPrivate,
      String signPublic, String signPrivate, String address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}

class KeysRestoreScreenFailure extends KeysRestoreScreenState {
  const KeysRestoreScreenFailure(String dataPublic, String dataPrivate,
      String signPublic, String signPrivate, String address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}
