/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/helper_permission.dart';
import '../keys_save_screen/keys_save_screen_service.dart';
import 'keys_save_dialog_dl_controller.dart';
import 'keys_save_dialog_dl_presenter.dart';
import 'model/keys_save_dialog_dl_model.dart';

class KeysSaveDialogDlService extends ChangeNotifier {
  late KeysSaveDialogDlPresenter presenter;
  late KeysSaveDialogDlController controller;
  late KeysSaveDialogDlModel model;
  final KeysSaveScreenService keysSaveScreenService;

  KeysSaveDialogDlService(
      {required this.keysSaveScreenService,
      required String combinedKey,
      required GlobalKey repaintKey}) {
    presenter = KeysSaveDialogDlPresenter(this,
        repaintKey: repaintKey, combinedKey: combinedKey);
    controller = KeysSaveDialogDlController();
    model = KeysSaveDialogDlModel();
  }

  Future<void> downloadQR(RenderRepaintBoundary renderRepaintBoundary) async {
    ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: 4.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    bool permission = await HelperPermission.request(Permission.storage);
    if (permission) {
      Directory documents;
      if (Platform.isIOS)
        documents = await getApplicationDocumentsDirectory();
      else
        documents = Directory("/storage/emulated/0/Download");

      String path = documents.path + '/tiki-do-not-share.png';
      File imgFile = new File(path);
      imgFile.writeAsBytesSync(pngBytes, flush: true);
      setDownloaded(true);
      keysSaveScreenService.keysDownloaded();
    } else
      setNoPermission(true);
    notifyListeners();
  }

  setDownloaded(bool state) {
    model.isDownloaded = state;
    notifyListeners();
  }

  setFailed(bool state) {
    model.isFailed = state;
    notifyListeners();
  }

  setNoPermission(bool state) {
    model.noPermission = state;
    notifyListeners();
  }
}
