/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_screen_service.dart';

class LoginInboxScreenResend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context);
    var presenter = service.presenter;
    return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(
            top: presenter.marginTopResend,
            bottom: presenter.marginBottomResend),
        child: Row(children: [
          Text(presenter.receiveText,
              style: TextStyle(
                  fontSize: presenter.resendFontSize,
                  fontWeight: FontWeight.w600)),
          TextButton(
              onPressed: () => service.controller.resend(context),
              child: Row(children: [
                Container(
                    margin: EdgeInsets.only(right: presenter.resendMarginRight),
                    child: Text(presenter.resendText,
                        style: TextStyle(
                            fontSize: presenter.resendFontSize,
                            fontWeight: FontWeight.bold,
                            color: ConfigColor.orange))),
                HelperImage("inbox-resend")
              ]))
        ]));
  }
}
