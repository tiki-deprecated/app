/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';

class SecurityScoreModalViewHack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('HACKING SCORE',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: ConfigColor.greyFour, fontWeight: FontWeight.bold)),
      Text(
          'A rating based on known recent security\nbreaches/hacks (from www.XXXXXXXXX.com)',
          style: TextStyle(fontWeight: FontWeight.bold))
    ]);
  }
}
