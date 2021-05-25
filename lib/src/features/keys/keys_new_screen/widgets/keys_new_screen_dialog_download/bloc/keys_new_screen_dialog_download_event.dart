/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_dialog_download_bloc.dart';

abstract class KeysNewScreenDialogDownloadEvent extends Equatable {
  const KeysNewScreenDialogDownloadEvent();

  @override
  List<Object> get props => [];
}

class KeysNewScreenDialogDownloaded extends KeysNewScreenDialogDownloadEvent {
  final GlobalKey globalKey;

  const KeysNewScreenDialogDownloaded(this.globalKey) : super();

  @override
  List<Object> get props => [globalKey];
}
