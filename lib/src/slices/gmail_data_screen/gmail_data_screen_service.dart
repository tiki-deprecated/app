import 'dart:io';
import 'dart:typed_data';

import 'package:app/src/slices/gmail_data_screen/model/gmail_data_screen_model.dart';
import 'package:app/src/utils/helper_permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gmail_data_screen_controller.dart';
import 'gmail_data_screen_presenter.dart';

class GmailDataScreenService extends ChangeNotifier {
  late GmailDataScreenModel model;
  late GmailDataScreenPresenter presenter;
  late GmailDataScreenController controller;

  GmailDataScreenService() {
    model = GmailDataScreenModel();
    controller = GmailDataScreenController();
    presenter = GmailDataScreenPresenter(this);
  }

  launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  shareCard(String message, String image) async {
    bool permission = await HelperPermission.request(Permission.storage);
    if (permission) {
      ByteData? bytes = await rootBundle.load("res/images/$image");
      var buffer = bytes.buffer;
      Uint8List pngBytes = buffer.asUint8List();
      Directory directory;
      if (Platform.isIOS)
        directory = await getApplicationDocumentsDirectory();
      else
        directory = (await getExternalStorageDirectory())!;
      String path = directory.path + '/tikishare.png';
      File imgFile = new File(path);
      imgFile.writeAsBytesSync(pngBytes, flush: true);
      Share.shareFiles(
        [path],
        text: message,
      );
    }
  }
}
