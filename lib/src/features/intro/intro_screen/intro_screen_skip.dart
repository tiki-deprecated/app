/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroScreenSkip extends StatelessWidget {
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;

  final String toPath;
  IntroScreenSkip(this.toPath);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(toPath);
        },
        child: Text('Skip',
            style: TextStyle(
                color: ConfigColor.black,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
