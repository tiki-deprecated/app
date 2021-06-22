/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginEmailScreenError extends StatelessWidget {
  static const String _text = "Please enter a valid email";
  static final double _fontSize = 4.w;

  @override
  Widget build(BuildContext context) {
    return _textWidget(true);
    }

  Widget _textWidget(bool isError) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _text,
          style: TextStyle(
              fontSize: isError ? _fontSize : 0,
              fontWeight: FontWeight.w500,
              color: isError ? ConfigColor.grenadier : ConfigColor.serenade),
        ));
  }
}
