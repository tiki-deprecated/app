/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';

class LoginOtpScreenLoad extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginOtpScreenLoad();
}

class _LoginOtpScreenLoad extends State<LoginOtpScreenLoad> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: Container(color: ConfigColor.sunglow)),
      Align(alignment: Alignment.topLeft, child: HelperImage('splash-blob-tl')),
      Stack(children: [
        Center(child: HelperImage('splash-logo-bkg')),
        Center(child: HelperImage('splash-logo'))
      ]),
      Align(
          alignment: Alignment.bottomRight,
          child: HelperImage('splash-blob-br')),
    ]);
  }
}
