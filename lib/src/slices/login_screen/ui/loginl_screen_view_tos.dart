/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreenViewTos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text("By pressing \"Continue\" you agree to TIKI's ",
            style: _textStyle(context)),
        _link(
            "Terms of Service", () => service.controller.tos(context), context),
        Text(" and ", style: _textStyle(context)),
        _link("Privacy Policy", () => service.controller.privacy(context),
            context),
      ],
    );
  }

  TextStyle _textStyle(context, {Color color = ConfigColor.boulder}) {
    var service = Provider.of<LoginScreenService>(context);
    return TextStyle(
        fontSize: service.presenter.fontSizeTos.sp,
        fontWeight: FontWeight.bold,
        color: color);
  }

  Widget _link(String text, Function() onPressed, BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 0,
      height: service.presenter.fontSizeTos.sp,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      child: Text(text, style: _textStyle(context, color: ConfigColor.orange)),
    );
  }
}
