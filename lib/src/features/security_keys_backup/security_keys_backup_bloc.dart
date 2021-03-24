/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';
import 'dart:ui';

import 'package:app/src/repositories/security_keys/security_keys_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class SecurityKeysBackupBloc {
  static final String _downloadFilename = "backup_keys";
  final SecurityKeysModel _keys;

  SecurityKeysBackupBloc({SecurityKeysModel keys}) : this._keys = keys;

  SecurityKeysModel get keys => _keys;

  Future<void> download(GlobalKey qrCode) async {
    RenderRepaintBoundary boundary = qrCode.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 4.0);
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();

    Directory documents;
    if (Platform.isIOS)
      documents = await getApplicationDocumentsDirectory();
    else
      documents = await getExternalStorageDirectory();

    File imgFile = new File(documents.path + '/' + _downloadFilename + ".png");
    imgFile.writeAsBytes(pngBytes);
  }

  String qrCodeData() {
    return _keys.id +
        "." +
        _keys.dataKeys.encodedPrivateKey +
        "." +
        _keys.signKeys.encodedPrivateKey;
  }
}
