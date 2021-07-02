/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TikiScreenViewLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return TextButton(
        onPressed: () => service.controller.logout(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(service.presenter.textLogout,
                style: TextStyle(
                    color: ConfigColor.grenadier,
                    fontWeight: FontWeight.bold,
                    fontSize: service.presenter.fontSizeLogout.sp)),
            Container(
                margin: EdgeInsets.only(left: 3.w),
                child: HelperImage("icon-logout",
                    height: service.presenter.fontSizeLogout.sp))
          ],
        ));
  }
}
