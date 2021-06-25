/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../tiki_screen_service.dart';

/// The [TikiScreenView] share section.
///
/// It handles the "share your code" action and renders the button.
class TikiScreenViewTikiBoxShare extends StatelessWidget {
  static const String _shareText = "It's your data. Get paid for it.";
  static final double _letterSpacing = 0.05.w;
  static final double _fontSize = 18.sp;
  static final double _marginHorizontal = 10.w;
  static final double _marginVertical = 2.25.h;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context, listen:false);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: _marginVertical, horizontal: _marginHorizontal),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.share),
            Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("SHARE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: _fontSize,
                          letterSpacing: _letterSpacing,
                        )))
              ],
            ),
          ],
        ),
        onPressed: service.controller.shareText(context, _shareText));
  }
}
