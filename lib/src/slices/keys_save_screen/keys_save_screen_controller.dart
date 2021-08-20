import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_user/model/api_user_model_keys.dart';
import '../keys_restore_screen/keys_restore_screen_service.dart';
import '../keys_save_dialog_copy/keys_save_dialog_copy_service.dart';
import '../keys_save_dialog_download/keys_save_dialog_dl_service.dart';
import 'keys_save_screen_service.dart';

class KeysSaveScreenController {
  final KeysSaveScreenService service;

  KeysSaveScreenController(this.service);

  goToHome() async {
    if (service.canContinue()) await service.saveAndLogin();
  }

  goToRestore(BuildContext context) => Navigator.of(context).push(
      KeysRestoreScreenService(service.loginFlowService)
          .presenter
          .createRoute(context));

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

  Future<void> onDownload(BuildContext context, GlobalKey repaintKey) async {
    ApiUserModelKeys keys = service.loginFlowService.model.user!.keys!;
    String combinedKey =
        keys.address! + '.' + keys.dataPrivateKey! + '.' + keys.signPrivateKey!;
    KeysSaveDialogDlService(
            keysSaveScreenService: service,
            combinedKey: combinedKey,
            repaintKey: repaintKey)
        .presenter
        .show(context);
  }

  Future<void> onBackup(BuildContext context) async {
    ApiUserModelKeys keys = service.loginFlowService.model.user!.keys!;
    String combinedKey =
        keys.address! + '.' + keys.dataPrivateKey! + '.' + keys.signPrivateKey!;
    KeysSaveDialogCopyService(
            combinedKey: combinedKey,
            email: service.loginFlowService.model.user!.user!.email!,
            keysSaveScreenService: service)
        .presenter
        .show(context);
  }
}
