/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/widgets/tiki_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [IntroScreen] skipper link.
class IntroScreenSkip extends StatelessWidget {
  static final int _fontSize = 4;

  final String toPath;

  IntroScreenSkip(this.toPath);

  @override
  Widget build(BuildContext context) {
    return TikiTextButton(
      "Skip",
      () => Navigator.of(context).pushNamed(toPath),
      fontWeight: FontWeight.bold,
      fontSize: _fontSize,
    );
  }
}
