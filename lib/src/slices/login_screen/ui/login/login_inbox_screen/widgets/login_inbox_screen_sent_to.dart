/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

class LoginInboxScreenSentTo extends StatelessWidget {
  static const String _text = "I sent an email with a link to";
  static final double _fontSize = 5.w;

  @override
  Widget build(BuildContext context) {
    var email;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_text,
            style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600)),
        Text(email == null ? "" : email!,
            style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold))
      ]);
  }
}
