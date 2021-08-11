/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/decision_screen/decision_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DecisionScreenController {
  final DecisionScreenService service;

  DecisionScreenController(this.service);

  void openLink(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  removeLast(BuildContext context, Function callback) {
    service.removeCard();
    service.refresh();
    callback(context);
  }
}
