/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';

class MdViewerLayoutBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.serenade)),
      Align(
        alignment: Alignment.topRight,
        child: HelperImage("home-blob-tr"),
      )
    ]);
  }
}
