/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_restore_screen/bloc/keys_restore_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenInput extends StatelessWidget {
  static final double _fontSize = 5.w;
  static final double _paddingHorizontal = 4.w;
  static final double _paddingVertical = 2.h;

  static const String _placeholder = "Your Account Key";

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _iosInput(context) : _androidInput(context);
  }

  Widget _iosInput(BuildContext context) {
    return CupertinoTextField(
        padding: EdgeInsets.symmetric(
            horizontal: _paddingHorizontal, vertical: _paddingVertical),
        placeholder: _placeholder,
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

  void onChanged(BuildContext context, String s) {
    BlocProvider.of<KeysRestoreScreenBloc>(context)
        .add(KeysRestoreScreenKeyUpdated(s));
  }
}
