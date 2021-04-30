/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeysNewScreenSaveSkip extends StatelessWidget {
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {},
        child: Text(ConfigString.keysNew.skipButton,
            style: TextStyle(
                color: ConfigColor.boulder,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
