/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:developer';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

class DeeplinkInboxBloc {
  void openInbox() {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
      );
      intent.launch().catchError((e) {
        log("Unable to launch inbox", error: e);
      });
    } else if (Platform.isIOS) {
      launch("message://").catchError((e) {
        log("Unable to launch inbox", error: e);
      });
    }
  }
}
