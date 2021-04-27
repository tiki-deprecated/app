/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/features/login_email_form/login_email_form_bloc.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailFormInputIos extends StatelessWidget {
  static final double _paddingHorizontal =
      4 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingVertical = 2 * PlatformRelativeSize.blockVertical;
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;
  final bool isError;

  LoginEmailFormInputIos({this.isError = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(
          horizontal: _paddingHorizontal, vertical: _paddingVertical),
      placeholder: ConfigString.loginEmail.placeholder,
      autocorrect: false,
      autofocus: true,
      placeholderStyle: TextStyle(
          color: ConfigColor.gray,
          fontWeight: FontWeight.bold,
          fontSize: _fontSize),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
      cursorColor: ConfigColor.orange,
      decoration: BoxDecoration(
          color: ConfigColor.white,
          border: Border(
              bottom: BorderSide(
                  color:
                      isError ? ConfigColor.grenadier : ConfigColor.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: (input) {
        BlocProvider.of<LoginEmailFormBloc>(context)
            .add(LoginEmailFormChanged(input));
      },
    );
  }
}
