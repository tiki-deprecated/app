/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../intro_screen_service.dart';

class IntroScreenSkipButton extends StatelessWidget {
  static const String _text = 'Skip';

  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<IntroScreenService>(context, listen: false).controller;
    return Container(
        child: TextButton(
            onPressed: () => controller.skipToLogin(context),
            child: Text(
              _text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            )));
  }
}
