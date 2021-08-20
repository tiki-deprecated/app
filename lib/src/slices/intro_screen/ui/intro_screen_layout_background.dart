/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/helper_image.dart';
import '../intro_screen_service.dart';

class IntroScreenBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context);
    return Stack(children: [
      Center(child: Container(color: service.getCurrentCard().backgroundColor)),
      Align(
        alignment: Alignment.bottomLeft,
        child: HelperImage('intro-blob'),
      ),
      Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(bottom: 5.h),
          child: HelperImage('intro-pineapple'))
    ]);
  }
}
