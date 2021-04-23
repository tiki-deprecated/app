/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiIntroSubtitle extends StatelessWidget {
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;

  final String text;
  UiIntroSubtitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold));
  }
}
