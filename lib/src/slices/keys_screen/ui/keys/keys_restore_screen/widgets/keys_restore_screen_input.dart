/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import 'package:app/src/config/config_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenInput extends StatelessWidget {
  static final double _fontSize = 5.w;
  static final double _paddingHorizontal = 4.w;
  static final double _paddingVertical = 2.h;

  static const String _placeholder = "Your Account Key";

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
      cursorColor: ConfigColor.orange,
      autocorrect: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: _paddingHorizontal, vertical: _paddingVertical),
          hintText: _placeholder,
          hintStyle: TextStyle(
              color: ConfigColor.gray,
              fontWeight: FontWeight.bold,
              fontSize: _fontSize),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ConfigColor.mardiGras,
                  width: 2,
                  style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ConfigColor.mardiGras,
                  width: 2,
                  style: BorderStyle.solid))),
      onChanged: (String s) => onChanged(context, s),
    );
  }

  onChanged(BuildContext context, String s) {}
}
