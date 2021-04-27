/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_string.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginEmailFormError extends StatelessWidget {
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;
  final bool isError;

  LoginEmailFormError({this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          ConfigString.loginEmail.error,
          style: TextStyle(
              fontSize: isError ? _fontSize : 0,
              fontWeight: FontWeight.w500,
              color: isError ? ConfigColor.grenadier : ConfigColor.serenade),
        ));
  }
}
