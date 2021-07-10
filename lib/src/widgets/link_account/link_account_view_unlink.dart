/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class LinkAccountViewUnlink extends StatelessWidget {
  static const String _text = "Unlink";
  static const num _fontSize = 9.5;

  final Function()? onUnlink;

  LinkAccountViewUnlink(this.onUnlink);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onUnlink,
        behavior: HitTestBehavior.opaque,
        child: Container(
            padding: EdgeInsets.only(
                top: 1.5.h, bottom: 1.5.h, left: 6.w, right: 3.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _text,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: _fontSize.sp,
                      color: ConfigColor.grenadier),
                ),
                Container(
                    margin: EdgeInsets.only(left: 1.w),
                    child: Image(
                      image: AssetImage('res/images/icon-circle-x.png'),
                      height: (_fontSize * 1.4).sp,
                      fit: BoxFit.fitHeight,
                    )),
              ],
            )));
  }
}
