/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_dialog_download_bloc.dart';

abstract class KeysNewScreenDialogDownloadState extends Equatable {
  const KeysNewScreenDialogDownloadState();

  @override
  List<Object> get props => [];
}

class KeysNewScreenDialogDownloadInitial
    extends KeysNewScreenDialogDownloadState {
  const KeysNewScreenDialogDownloadInitial() : super();
}

class KeysNewScreenDialogDownloadSuccess
    extends KeysNewScreenDialogDownloadState {
  final String path;

  const KeysNewScreenDialogDownloadSuccess(this.path) : super();

  @override
  List<Object> get props => [path];
}
