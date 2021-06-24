/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro_screen_service.dart';

class IntroScreenBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var bgcolor = service.model.getCurrentSlide().backgroundColor;
    return Stack(children: [
      Center(child: Container(color: bgcolor)),
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
