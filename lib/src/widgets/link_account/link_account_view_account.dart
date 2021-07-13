/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class LinkAccountViewAccount extends StatelessWidget {
  final String icon;
  final String type;
  final String username;

  LinkAccountViewAccount(
      {required this.icon, required this.type, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image(
        image: AssetImage('res/images/' + icon + '.png'),
        height: 3.5.h,
        fit: BoxFit.fitHeight,
      ),
      Container(
          margin: EdgeInsets.only(left: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ConfigColor.greyFour,
                      height: 1,
                      fontSize: 11.sp)),
              Text(username,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ConfigColor.tikiBlue,
                      height: 1,
                      fontSize: 14.sp))
            ],
          ))
    ]);
  }
}
