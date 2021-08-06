/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'md_screen_service.dart';

class MdScreenController {
  final MdScreenService service;

  MdScreenController(this.service);

  back(BuildContext context) {
    Navigator.of(context).pop();
  }

  openUrl(String? href) async {
    if (href != null && await canLaunch(href)) await launch(href);
  }
}
