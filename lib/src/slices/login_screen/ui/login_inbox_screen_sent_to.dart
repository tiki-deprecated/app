/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../login_screen_service.dart';
import 'package:sizer/sizer.dart';

class LoginInboxScreenSentTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Container(
        alignment: Alignment.topLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(service.presenter.sendToText,
              style: TextStyle(
                  fontSize: service.presenter.sendToFontSize.sp,
                  fontWeight: FontWeight.w600)),
          Text(service.model.email,
              style: TextStyle(
                  fontSize: service.presenter.sendToFontSize.sp,
                  fontWeight: FontWeight.bold))
        ]));
  }
}
