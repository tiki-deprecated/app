/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro_screen_service.dart';
import 'intro_screen_layout_background.dart';
import 'intro_screen_layout_foreground.dart';
import 'package:sizer/sizer.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service =
        Provider.of<IntroScreenService>(context, listen: false);
    var controller = service.controller;
    var presenter = service.presenter;
    presenter.margins = {
      "marginTopText" : 2.5.h,
      "marginTopButton" : 5.h,
      "marginTopTitle" : 15.h,
      "marginTopSkip" : 2.h,
      "marginRightText" : 10.h,
    };
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(children: [
                  IntroScreenBackground(),
                  IntroScreenForeground()
                ]),
                onHorizontalDragEnd: (dragEndDetails) =>
                    controller.onHorizontalDrag(context, dragEndDetails))));
  }
}
