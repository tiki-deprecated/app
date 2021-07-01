/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MdViewerController {
  back(BuildContext context) {
    Navigator.of(context).pop();
  }

  openUrl(String? href) async {
    if (href != null && await canLaunch(href)) await launch(href);
  }
}
