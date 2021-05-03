/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_download_bloc.dart';

abstract class KeysNewScreenDownloadState extends Equatable {
  final bool shouldShare;

  const KeysNewScreenDownloadState(this.shouldShare);

  @override
  List<Object> get props => [shouldShare];
}

class KeysNewScreenDownloadInitial extends KeysNewScreenDownloadState {
  const KeysNewScreenDownloadInitial(bool shouldShare) : super(shouldShare);
}

class KeysNewScreenDownloadInProgress extends KeysNewScreenDownloadState {
  const KeysNewScreenDownloadInProgress(shouldShare) : super(shouldShare);
}

class KeysNewScreenDownloadSuccess extends KeysNewScreenDownloadState {
  final String path;

  const KeysNewScreenDownloadSuccess(bool shouldShare, this.path)
      : super(shouldShare);

  @override
  List<Object> get props => [shouldShare, path];
}
