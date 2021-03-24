/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';
import 'dart:ui';

import 'package:app/src/helpers/helper_security_keys/helper_security_keys_bloc.dart';
import 'package:app/src/helpers/helper_security_keys/helper_security_keys_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class UISecurityBackupBloc {
  static final String _downloadFilename = "backup_keys";
  HelperSecurityKeysModel _keys;

  UISecurityBackupBloc(HelperSecurityKeysBloc helperSecurityKeysBloc,
      {HelperSecurityKeysModel provided}) {
    _keys = provided;
    helperSecurityKeysBloc.observable.listen((keys) {
      _keys = keys;
    });
  }

  HelperSecurityKeysModel get keys => _keys;

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
    return _keys.address +
        "." +
        _keys.dataKey.encodedPrivate +
        "." +
        _keys.signKey.encodedPrivate;
  }
}
