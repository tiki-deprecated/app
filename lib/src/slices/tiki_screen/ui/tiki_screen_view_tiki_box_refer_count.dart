/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTikiBoxReferCount extends StatelessWidget {

  static const String _text = "people joined";
  static final double _fontSize = 14.sp;
  static final double _marginRight = 2.w;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen:false);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.only(right: _marginRight),
          child: HelperImage("ref-user")),
      Text(
          service.model.count.toString() + " "
              +
              _text,
          style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
              color: ConfigColor.jade))
    ]);
  }
}
