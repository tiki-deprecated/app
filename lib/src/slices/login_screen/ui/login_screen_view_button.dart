/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_screen/login_screen_service.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The login screen button.
///
/// The button that starts the login proccess. Uses bloc pattern.
///
/// * See also [LoginOtpReqBloc]
class LoginScreenViewButton extends StatelessWidget {
  static const String _text = "CONTINUE";

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<LoginScreenService>(context, listen:false);
    return Container(
        margin: EdgeInsets.only(top: service.presenter.marginTopButton),
        child: TikiBigButton(_text, true, service.controller.submitLogin));
  }
}
