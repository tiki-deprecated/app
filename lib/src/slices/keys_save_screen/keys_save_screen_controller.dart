import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_routes.dart';
import 'package:app/src/slices/keys_save_screen/keys_save_screen_service.dart';
import 'package:app/src/utils/helper_permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class KeysSaveScreenController {
  goToHome(context) {
    AppService appService = Provider.of<AppService>(context);
    appService.home = AppModelRoutes.home;
    appService.reload();
  }

  copyKey(KeysSaveScreenService keysService, String key) {
    Clipboard.setData(new ClipboardData(text: key));
    keysService.keySaved();
  }

  downloadQR(KeysSaveScreenService keysService,
      GlobalKey<State<StatefulWidget>> repaintKey) async {
    RenderRepaintBoundary renderRepaintBoundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    if (!renderRepaintBoundary.debugNeedsPaint) {
      ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: 4.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
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
      }
    }
    keysService.keysDonwloaded();
  }
}
