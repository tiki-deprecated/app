/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/config/config_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro_screen_service.dart';
import 'package:sizer/sizer.dart';

class IntroScreenButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var marginTop = service.presenter.marginTopButton;
    var buttonText = service.presenter.buttonText;
    return Container(
        margin: EdgeInsets.only(top: marginTop),
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: 2.25.h,
                    horizontal: 10.w
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.h))),
                primary: ConfigColor.mardiGras,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            right: 1.w),
                        child: Text(buttonText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              letterSpacing: 0.05.w,
                            )))
                  ],
                ),
              ],
            ),
            onPressed: () => service.controller.navigateToNextScreen(context)
        )
    );
  }
}
