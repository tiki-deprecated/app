/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro_screen_service.dart';

class IntroScreenSubtitle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<IntroScreenService>(context, listen: false);
    var marginTop = service.presenter.marginTopText;
    var marginRight = service.presenter.marginRightText;
    return Container(
        margin: EdgeInsets.only(top: marginTop, right: marginRight),
        child: Text(service.presenter.subtitle,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold))
    );
  }

}
