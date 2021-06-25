/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../login_screen_service.dart';

class LoginInboxScreenTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Container(
        margin: EdgeInsets.only(top: service.presenter.marginTopTitle.h),
        alignment: Alignment.centerLeft,
        child: Text(service.presenter.title,
            style: TextStyle(
                fontFamily: 'Koara',
                fontSize: service.presenter.inboxTitleFontSize.sp,
                fontWeight: FontWeight.bold)));
  }
}
