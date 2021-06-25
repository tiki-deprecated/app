/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../intro_screen_service.dart';

class IntroScreenSkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var text = service.presenter.textSkip;
    return Container(
        child: TextButton(
            onPressed: () => service.controller.skipToLogin(context),
            child: Text(
              text,
              style: TextStyle(
                color: ConfigColor.black,
                fontWeight: FontWeight.bold,
                fontSize: service.presenter.fontSizeSkip.sp,
              ),
            )));
  }
}
