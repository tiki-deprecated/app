/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewTikiBoxReferCode extends StatelessWidget {
  static const String _text = "YOUR CODE";
  static final double _fontSize = 4.w;
  static final double _marginLeft = 1.w;
  static final double _marginRight = 3.w;
  static final double _marginVertical = 1.5.h;
  static final double _borderRadius = 1.5.h;

  @override
  Widget build(BuildContext context) {
    var link = Provider.of<TikiScreenService>(context, listen:false).model.link;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: OutlinedButton(
            onPressed: () async {

              Clipboard.setData(new ClipboardData(text: link.toString()));
            },
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: ConfigColor.alto),
                primary: ConfigColor.gray,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(_borderRadius)))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_text,
                  style: TextStyle(
                      fontSize: _fontSize,
                      fontWeight: FontWeight.bold,
                      color: ConfigColor.gray)),
              Container(
                  margin: EdgeInsets.only(
                      left: _marginLeft,
                      right: _marginRight,
                      top: _marginVertical,
                      bottom: _marginVertical),
                  child: Text(
                      link
                          .toString()
                          .replaceAll(new RegExp(r'https://mytiki.app/'), ''),
                      style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: FontWeight.bold,
                          color: ConfigColor.tikiBlue))),
              HelperImage("icon-copy"),
            ])));
  }
}
