/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

part 'keys_new_screen_download_event.dart';
part 'keys_new_screen_download_state.dart';

class KeysNewScreenDownloadBloc
    extends Bloc<KeysNewScreenDownloadEvent, KeysNewScreenDownloadState> {
  static const fileName = "tiki-do-not-share.png";

  KeysNewScreenDownloadBloc() : super(KeysNewScreenDownloadInitial(false));

  @override
  Stream<KeysNewScreenDownloadState> mapEventToState(
    KeysNewScreenDownloadEvent event,
  ) async* {
    if (event is KeysNewScreenDownloaded)
      yield* _mapDownloadedToState(event);
    else if (event is KeysNewScreenDownloadRendered)
      yield* _mapRenderedToState(event);
  }

  Stream<KeysNewScreenDownloadState> _mapDownloadedToState(
      KeysNewScreenDownloaded downloaded) async* {
    yield KeysNewScreenDownloadInProgress(downloaded.shouldShare);
  }

  Stream<KeysNewScreenDownloadState> _mapRenderedToState(
      KeysNewScreenDownloadRendered rendered) async* {
    RenderRepaintBoundary renderRepaintBoundary =
        rendered.globalKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;
    ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: 4.0);
    ByteData byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData>);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    Directory documents;
    if (Platform.isIOS)
      documents = await getApplicationDocumentsDirectory();
    else
      documents = Directory((await getExternalStorageDirectory())!
              .parent
              .parent
              .parent
              .parent
              .path +
          "/Download");

    String path = documents.path + '/' + fileName;
    File imgFile = new File(path);
    await imgFile.writeAsBytes(pngBytes, flush: true);
    yield KeysNewScreenDownloadSuccess(rendered.shouldShare, path);
  }
}
