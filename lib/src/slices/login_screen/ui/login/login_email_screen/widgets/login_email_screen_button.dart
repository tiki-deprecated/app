/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The login screen button.
///
/// The button that starts the login proccess. Uses bloc pattern.
///
/// * See also [LoginOtpReqBloc]
class LoginEmailScreenButton extends StatelessWidget {
  static const String _text = "CONTINUE";

  @override
  Widget build(BuildContext context) {
    return TikiBigButton(_text, true, _submitLogin);
  }


  _submitLogin() {
  }
}
