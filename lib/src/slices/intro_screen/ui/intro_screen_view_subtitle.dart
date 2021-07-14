/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../intro_screen_service.dart';

class IntroScreenSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    return Text(service.presenter.textSubtitle,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold));
  }
}
