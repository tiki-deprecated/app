/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app/src/utils/helper/helper_permission.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'keys_new_screen_dialog_download_event.dart';
part 'keys_new_screen_dialog_download_state.dart';

class KeysNewScreenDialogDownloadBloc extends Bloc<
    KeysNewScreenDialogDownloadEvent, KeysNewScreenDialogDownloadState> {
  static const fileName = "tiki-do-not-share.png";

  KeysNewScreenDialogDownloadBloc()
      : super(KeysNewScreenDialogDownloadInitial());

  @override
  Stream<KeysNewScreenDialogDownloadState> mapEventToState(
    KeysNewScreenDialogDownloadEvent event,
  ) async* {
    if (event is KeysNewScreenDialogDownloaded)
      yield* _mapDownloadedToState(event);
  }

  Stream<KeysNewScreenDialogDownloadState> _mapDownloadedToState(
      KeysNewScreenDialogDownloaded downloaded) async* {
    RenderRepaintBoundary renderRepaintBoundary =
        downloaded.globalKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;
    if(!renderRepaintBoundary.debugNeedsPaint){
    ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: 4.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    bool permission = await HelperPermission.request(Permission.storage);
    if (permission) {
      Directory documents;
      if (Platform.isIOS)
        documents = await getApplicationDocumentsDirectory();
      else {
        documents = Directory("/storage/emulated/0/Download");

        String path = documents.path + '/' + fileName;
        File imgFile = new File(path);

        imgFile.writeAsBytesSync(pngBytes, flush: true);
        yield KeysNewScreenDialogDownloadSuccess(path);
      }
    }
  }}
}
