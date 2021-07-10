/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class LinkAccountViewAdd extends StatelessWidget {
  static const num _height = 7;

  final String text;
  final String icon;
  final Function()? onLink;

  LinkAccountViewAdd({required this.text, required this.icon, this.onLink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onLink, // controller.onLink(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          decoration: BoxDecoration(
            color: ConfigColor.white,
            borderRadius: BorderRadius.circular(4.w),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2.w,
                offset: Offset(0.75.w, 0.75.w), // Shadow position
              ),
            ],
          ),
          child: Row(children: [
            Image(
              image: AssetImage('res/images/' + icon + '.png'),
              height: 2.h,
              fit: BoxFit.fitHeight,
            ),
            Container(
                color: ConfigColor.gallery,
                width: 1.sp,
                height: _height.h,
                margin: EdgeInsets.only(left: 4.w)),
            Container(
                margin: EdgeInsets.only(left: 4.w),
                child: Text(text,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: ConfigColor.tikiBlue))),
            Expanded(
                child: Image(
              alignment: Alignment.centerRight,
              image: AssetImage('res/images/icon-act-plus.png'),
              height: 3.75.h,
              fit: BoxFit.fitHeight,
            )),
          ]),
        ));
  }
}
