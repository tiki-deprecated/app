/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'keys_save_dialog_copy_button.dart';
import 'keys_save_dialog_copy_field.dart';
import 'keys_save_dialog_copy_field_heading.dart';
import 'keys_save_dialog_copy_subtitle.dart';
import 'keys_save_dialog_copy_title.dart';

class KeysSaveDialogCopy extends StatelessWidget {
  final String combinedKey;
  final String email;

  KeysSaveDialogCopy({required this.combinedKey, required this.email});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Container(
            margin: EdgeInsets.only(top: 4.h),
            child: KeysSaveDialogCopyTitle()),
        content: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              margin: EdgeInsets.only(top: 2.h),
              child: KeysSaveDialogCopySubtitle()),
          Container(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Column(
                children: [
                  KeysSaveDialogCopyFieldHeading(),
                  Container(
                      margin: EdgeInsets.only(top: 0.5.h),
                      child:
                          KeysSaveDialogCopyField(value: email, isEmail: true)),
                  Container(
                      margin: EdgeInsets.only(top: 0.5.h),
                      child: KeysSaveDialogCopyField(
                          value: combinedKey, isEmail: false)),
                ],
              )),
          KeysSaveDialogCopyButton()
        ])));
  }
}
