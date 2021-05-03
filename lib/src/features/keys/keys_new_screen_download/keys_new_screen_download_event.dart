/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_download_bloc.dart';

abstract class KeysNewScreenDownloadEvent extends Equatable {
  final bool shouldShare;

  const KeysNewScreenDownloadEvent(this.shouldShare);

  @override
  List<Object> get props => [shouldShare];
}

class KeysNewScreenDownloaded extends KeysNewScreenDownloadEvent {
  const KeysNewScreenDownloaded(bool shouldShare) : super(shouldShare);
}

class KeysNewScreenDownloadRendered extends KeysNewScreenDownloadEvent {
  final GlobalKey globalKey;

  const KeysNewScreenDownloadRendered(this.globalKey, bool shouldShare)
      : super(shouldShare);

  @override
  List<Object> get props => [globalKey, shouldShare];
}
