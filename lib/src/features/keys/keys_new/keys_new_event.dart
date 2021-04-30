/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_bloc.dart';

abstract class KeysNewEvent extends Equatable {
  const KeysNewEvent();

  @override
  List<Object> get props => [];
}

class KeysNewGenerated extends KeysNewEvent {
  const KeysNewGenerated() : super();
}

class KeysNewSkipped extends KeysNewEvent {
  const KeysNewSkipped() : super();
}

class KeysNewDownloaded extends KeysNewEvent {
  const KeysNewDownloaded() : super();
}

class KeysNewRendered extends KeysNewEvent {
  final GlobalKey globalKey;

  const KeysNewRendered(this.globalKey) : super();

  @override
  List<Object> get props => [globalKey];
}
