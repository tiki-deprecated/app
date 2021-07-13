/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'md_viewer_service.dart';

class MdViewerController {
  final MdViewerService service;

  MdViewerController(this.service);

  back(BuildContext context) {
    Navigator.of(context).pop();
  }

  openUrl(String? href) async {
    if (href != null && await canLaunch(href)) await launch(href);
  }
}
