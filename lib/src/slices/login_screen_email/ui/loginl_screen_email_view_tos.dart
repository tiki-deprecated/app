/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import '../login_screen_email_service.dart';

class LoginScreenEmailViewTos extends StatelessWidget {
  static const num _fontSize = 10;

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenEmailService>(context);
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

  TextStyle _textStyle(context, {Color color = ConfigColor.greySix}) {
    return TextStyle(
        fontSize: _fontSize.sp, fontWeight: FontWeight.bold, color: color);
  }

  Widget _link(String text, Function() onPressed, BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 0,
      height: _fontSize.sp,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      child: Text(text, style: _textStyle(context, color: ConfigColor.orange)),
    );
  }
}
