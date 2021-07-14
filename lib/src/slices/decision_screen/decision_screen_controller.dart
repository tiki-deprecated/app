/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/decision_screen/decision_screen_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DecisionScreenController {
  void openLink(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  removeAt(context, int i) {
    Provider.of<DecisionScreenService>(context, listen: false).removeCard(i);
  }
}
