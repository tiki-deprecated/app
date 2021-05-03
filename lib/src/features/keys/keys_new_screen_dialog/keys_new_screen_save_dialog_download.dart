/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class KeysNewScreenSaveDialogDownload extends StatelessWidget {
  static const String _title = "Location Saved";
  static const String _locationAndroid =
      "Files > Downloads > tiki-do-not-share.png";
  static const String _locationIOS =
      "Files > On My iPhone > TIKI > tiki-do-not-share.png";
  static const String _open = "Go to File";

  final String path;

  KeysNewScreenSaveDialogDownload(this.path);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return _ios(context);
    else
      return _android(context);
  }

  AlertDialog _android(BuildContext context) {
    return AlertDialog(
        title: Text(_title), content: _content(), actions: [_button()]);
  }

  CupertinoAlertDialog _ios(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(_title),
      content: _content(),
      actions: [_button()],
    );
  }

  Widget _content() {
    return Container(
        margin: EdgeInsets.only(top: 1 * PlatformRelativeSize.blockVertical),
        child: Text(Platform.isIOS ? _locationIOS : _locationAndroid,
            textAlign: TextAlign.justify));
  }

  Widget _button() {
    return TextButton(
      child: Text(_open),
      onPressed: () async {
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: "android.intent.action.VIEW",
            data: path,
            type: "image/png",
          );
          intent.launch().catchError((e) {
            Sentry.captureException(Exception("Failed to open Files app"),
                stackTrace: StackTrace.current);
          });
        } else
          await launch("shareddocuments://" + path);
      },
    );
  }
}
