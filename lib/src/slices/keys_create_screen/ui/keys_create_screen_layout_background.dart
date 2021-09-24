/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';

class KeysCreateScreenLayoutBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.cream)),
      Align(
          alignment: Alignment.topRight,
          child: HelperImage("keys-blob", width: 18.5.h))
    ]);
  }
}
