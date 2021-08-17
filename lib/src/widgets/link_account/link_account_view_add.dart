/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class LinkAccountViewAdd extends StatelessWidget {
  static const double _height = 40;

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
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: _height,
          decoration: BoxDecoration(
            color: ConfigColor.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2.w,
                offset: Offset(0.75.w, 0.75.w), // Shadow position
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Image(
              image: AssetImage('res/images/' + icon + '.png'),
              height: 24,
              fit: BoxFit.fitHeight,
            ),
            Container(
                margin: EdgeInsets.only(left: 24),
                child: Text(text,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.w500,
                        color: Colors.black54))),
          ]),
        ));
  }
}
