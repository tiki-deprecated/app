/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class SecurityScoreModalViewEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
          'We’re sorry that we cannot provide you with a\nsecurity score for this email list right now.\nFind out more info about security score below.',
          style: TextStyle(
              color: ConfigColor.tikiRed, fontWeight: FontWeight.bold)),
      Padding(padding: EdgeInsets.only(top: 2.h)),
    ]);
  }
}
