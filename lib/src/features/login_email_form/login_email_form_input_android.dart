/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_email_form_bloc.dart';

class LoginEmailFormInputAndroid extends StatelessWidget {
  static final double _paddingHorizontal =
      4 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingVertical = 4 * PlatformRelativeSize.blockVertical;
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;
  final bool isError;

  LoginEmailFormInputAndroid({this.isError = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
      cursorColor: ConfigColor.orange,
      autocorrect: false,
      autofocus: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: _paddingHorizontal, vertical: _paddingVertical),
          hintText: ConfigString.loginEmail.placeholder,
          hintStyle: TextStyle(
              color: ConfigColor.gray,
              fontWeight: FontWeight.bold,
              fontSize: _fontSize),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      isError ? ConfigColor.grenadier : ConfigColor.mardiGras,
                  width: 2,
                  style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
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
