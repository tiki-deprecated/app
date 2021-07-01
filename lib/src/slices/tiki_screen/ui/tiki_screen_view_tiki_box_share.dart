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
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 16.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            primary: ConfigColor.mardiGras),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                padding: EdgeInsets.only(right: 5.w),
                child: Text(service.presenter.textTikiBoxReferShare,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: service.presenter.fontSizeTikiBoxReferShare.sp,
                      letterSpacing: 0.05.w,
                    ))),
            Icon(
              Icons.share,
              size: service.presenter.fontSizeTikiBoxReferShare.sp * 1.2,
            ),
          ],
        ),
        onPressed: () => service.controller.shareText(context));
  }
}
