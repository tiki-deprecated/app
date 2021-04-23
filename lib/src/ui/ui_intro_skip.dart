/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/platform/platform_page_route.dart';
import 'package:app_stash/src/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiIntroSkip extends StatelessWidget {
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;

  final Widget to;
  UiIntroSkip(this.to);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(context, PlatformPageRoute.screen(to));
        },
        child: Text('Skip',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: _fontSize)));
  }
}
