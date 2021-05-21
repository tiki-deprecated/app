/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class KeysRestoreScreenInput extends StatelessWidget {
  static final double _fontSize = 5 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingHorizontal =
      4 * PlatformRelativeSize.blockHorizontal;
  static final double _paddingVertical = 2 * PlatformRelativeSize.blockVertical;

  final String placeholder;

  KeysRestoreScreenInput(this.placeholder);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _iosInput(context) : _androidInput(context);
  }

  Widget _iosInput(BuildContext context) {
    return CupertinoTextField(
        padding: EdgeInsets.symmetric(
            horizontal: _paddingHorizontal, vertical: _paddingVertical),
        placeholder: placeholder,
        autocorrect: false,
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
                    color: ConfigColor.mardiGras,
                    width: 2,
                    style: BorderStyle.solid))),
        onChanged: (String s) => onChanged(context, s));
  }

  Widget _androidInput(BuildContext context) {
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
      cursorColor: ConfigColor.orange,
      autocorrect: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: _paddingHorizontal, vertical: _paddingVertical),
          hintText: placeholder,
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

  void onChanged(BuildContext context, String s);
}
