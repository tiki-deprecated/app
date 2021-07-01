/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';

class LoginScreenInboxTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Text(service.presenter.textInbox,
        style: TextStyle(
            fontFamily: 'Koara',
            fontSize: service.presenter.fontSizeInboxTitle.sp,
            fontWeight: FontWeight.bold));
  }
}
