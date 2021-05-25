/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_bloc.dart';

abstract class KeysNewScreenEvent extends Equatable {
  const KeysNewScreenEvent();

  @override
  List<Object> get props => [];
}

class KeysNewScreenGenerated extends KeysNewScreenEvent {
  const KeysNewScreenGenerated() : super();
}

class KeysNewScreenBackedUp extends KeysNewScreenEvent {
  const KeysNewScreenBackedUp() : super();
}

class KeysNewScreenContinue extends KeysNewScreenEvent {
  const KeysNewScreenContinue() : super();
}
