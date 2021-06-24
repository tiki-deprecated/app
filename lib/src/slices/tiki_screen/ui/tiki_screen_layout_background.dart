/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tiki_screen_service.dart';

class TikiScreenLayoutBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen:false);
    return Stack(children: [
      Center(child: Container(color: service.presenter.bgcolor)),
      Align(
        alignment: Alignment.topRight,
        child: HelperImage(
          "home-locker-tr",
          width: service.presenter.lockerWidth(context),
        ),
      ),
    ]);
  }
}

