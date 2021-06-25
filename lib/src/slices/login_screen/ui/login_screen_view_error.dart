/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../login_screen_service.dart';

class LoginScreenViewError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          service.presenter.errorText,
          style: TextStyle(
              fontSize:
                  service.model.isError ? service.presenter.errorFontSize.sp : 0,
              fontWeight: FontWeight.w500,
              color: service.model.isError
                  ? ConfigColor.grenadier
                  : ConfigColor.serenade),
        ));
  }
}
