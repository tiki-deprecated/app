/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'google_oauth_modal_service.dart';

class GoogleOauthModalController {
  final GoogleOauthModalService service;

  GoogleOauthModalController(this.service);

  Future<void> openLink(String? href) async {
    if (href != null && await canLaunch(href)) await launch(href);
  }

  Future<void> onOk(BuildContext context) async {
    Navigator.of(context).pop();
    return service.finished();
  }
}
