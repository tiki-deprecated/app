/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';

class LoginScreenInboxSentTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(service.presenter.sendToText,
          style: TextStyle(
              color: ConfigColor.emperor,
              fontSize: service.presenter.sendToFontSize.sp,
              fontWeight: FontWeight.w600)),
      Text(service.model.email,
          style: TextStyle(
              color: ConfigColor.emperor,
              fontSize: service.presenter.sendToFontSize.sp,
              fontWeight: FontWeight.bold))
    ]);
  }
}
