/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:url_launcher/url_launcher.dart';

import 'security_score_modal_service.dart';

class SecurityScoreModalController {
  final SecurityScoreModalService service;

  SecurityScoreModalController(this.service);

  Future<void> openLink(String? href) async {
    if (href != null && await canLaunch(href)) await launch(href);
  }
}
