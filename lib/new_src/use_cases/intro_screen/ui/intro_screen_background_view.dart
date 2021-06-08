/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper/helper_image.dart';
import 'package:flutter/material.dart';

class IntroScreenBackgroundView extends StatelessWidget {
  final Color backgroundColor;

  IntroScreenBackgroundView({required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: this.backgroundColor)),
      Align(
        alignment: Alignment.bottomLeft,
        child: HelperImage('intro-blob'),
      ),
      Align(
          alignment: Alignment.bottomRight,
          child: HelperImage('intro-pineapple'))
    ]);
  }
}
