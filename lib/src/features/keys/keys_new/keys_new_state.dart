/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_bloc.dart';

abstract class KeysNewState extends Equatable {
  final String dataPublic;
  final String dataPrivate;
  final String signPublic;
  final String signPrivate;
  final String address;

  const KeysNewState(this.dataPublic, this.dataPrivate, this.signPublic,
      this.signPrivate, this.address);

  @override
  List<Object> get props =>
      [dataPublic, dataPrivate, signPublic, signPrivate, address];
}

class KeysNewInitial extends KeysNewState {
  const KeysNewInitial() : super(null, null, null, null, null);
}

class KeysNewGenerateInProgress extends KeysNewState {
  const KeysNewGenerateInProgress(String dataPublic, String dataPrivate,
      String signPublic, String signPrivate, String address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}

class KeysNewDownloadInProgress extends KeysNewState {
  const KeysNewDownloadInProgress(String dataPublic, String dataPrivate,
      String signPublic, String signPrivate, String address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}

class KeysNewSuccess extends KeysNewState {
  const KeysNewSuccess(String dataPublic, String dataPrivate, String signPublic,
      String signPrivate, String address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}

class KeysNewFailure extends KeysNewState {
  const KeysNewFailure(String dataPublic, String dataPrivate, String signPublic,
      String signPrivate, String address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}
