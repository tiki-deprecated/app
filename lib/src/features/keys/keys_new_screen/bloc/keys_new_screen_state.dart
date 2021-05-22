/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_bloc.dart';

abstract class KeysNewScreenState extends Equatable {
  final String? dataPublic;
  final String? dataPrivate;
  final String? signPublic;
  final String? signPrivate;
  final String? address;

  const KeysNewScreenState(this.dataPublic, this.dataPrivate, this.signPublic,
      this.signPrivate, this.address);

  @override
  List<Object?> get props =>
      [dataPublic, dataPrivate, signPublic, signPrivate, address];
}

class KeysNewScreenInitial extends KeysNewScreenState {
  const KeysNewScreenInitial() : super(null, null, null, null, null);
}

class KeysNewScreenInProgress extends KeysNewScreenState {
  final bool isBackedUp;

  const KeysNewScreenInProgress(String? dataPublic, String? dataPrivate,
      String? signPublic, String? signPrivate, String? address, this.isBackedUp)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);

  @override
  List<Object?> get props =>
      [dataPublic, dataPrivate, signPublic, signPrivate, address, isBackedUp];
}

class KeysNewScreenCanContinue extends KeysNewScreenState {

  const KeysNewScreenCanContinue(String? dataPublic, String? dataPrivate,
      String? signPublic, String? signPrivate, String? address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);

  @override
  List<Object?> get props =>
      [dataPublic, dataPrivate, signPublic, signPrivate, address];

}

class KeysNewScreenSuccess extends KeysNewScreenState {
  const KeysNewScreenSuccess(String? dataPublic, String? dataPrivate,
      String? signPublic, String? signPrivate, String? address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}

class KeysNewScreenFailure extends KeysNewScreenState {
  const KeysNewScreenFailure(String? dataPublic, String? dataPrivate,
      String? signPublic, String? signPrivate, String? address)
      : super(dataPublic, dataPrivate, signPublic, signPrivate, address);
}
