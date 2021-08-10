/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';

class SecurityScoreModalViewSensitive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('SENSITIVITY SCORE',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: ConfigColor.greyFour, fontWeight: FontWeight.bold)),
      Text(
          'A rating based on the sensitivity of the\nbusiness emailing you, for example whether\nthey are holding nmedical or financial\ninformation vs a clothing company. We find this\ninformation at www.XXXXXXXXX.com.',
          style: TextStyle(fontWeight: FontWeight.bold))
    ]);
  }
}
