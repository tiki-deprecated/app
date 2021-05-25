/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

part of 'keys_new_screen_dialog_download_bloc.dart';

abstract class KeysNewScreenDialogDownloadEvent extends Equatable {
  final GlobalKey globalKey;

  const KeysNewScreenDialogDownloadEvent(this.globalKey);

  @override
  List<Object> get props => [globalKey];
}

class KeysNewScreenDialogDownloaded extends KeysNewScreenDialogDownloadEvent {
  const KeysNewScreenDialogDownloaded(GlobalKey globalKey) : super(globalKey);
}
