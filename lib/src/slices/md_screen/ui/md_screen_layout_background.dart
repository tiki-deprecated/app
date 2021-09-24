/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

import '../../../config/config_color.dart';
import '../../../utils/helper_image.dart';

class MdScreenLayoutBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.cream)),
      Align(
        alignment: Alignment.topRight,
        child: HelperImage("home-blob-tr"),
      )
    ]);
  }
}
