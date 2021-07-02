import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/app/model/app_model_routes.dart';
import 'package:app/src/slices/keys_restore_screen/keys_restore_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class KeysSaveScreenController {
  goToHome(context) {
    AppService appService = Provider.of<AppService>(context, listen: false);
    appService.home = AppModelRoutes.home;
    appService.reload();
  }

  goToRestore(BuildContext context) {
    AppService appService = Provider.of<AppService>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => KeysRestoreScreenService(appService).getUI()));
  }

  goToDownloadLocation() async {
    if (Platform.isAndroid) {
      Directory documents = Directory("/storage/emulated/0/Download");
      AndroidIntent intent = AndroidIntent(
        action: "android.intent.action.VIEW",
        data: documents.path + '/tiki-do-not-share.png',
        type: "image/png",
      );
      intent.launch().catchError((e) {
        throw Exception("Failed to open Files app");
      });
    } else {
      Directory documents = await getApplicationDocumentsDirectory();
      await launch("shareddocuments:///private" +
          documents.path +
          "/tiki-do-not-share.png");
    }
  }
}
