/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'keys_save_dialog_copy_view_button.dart';
import 'keys_save_dialog_copy_view_field.dart';
import 'keys_save_dialog_copy_view_field_heading.dart';
import 'keys_save_dialog_copy_view_subtitle.dart';
import 'keys_save_dialog_copy_view_title.dart';

class KeysSaveDialogCopyLayout extends StatelessWidget {
  final String combinedKey;
  final String email;

  KeysSaveDialogCopyLayout({required this.combinedKey, required this.email});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        titlePadding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w),
        title: KeysSaveDialogCopyViewTitle(),
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 6.h),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              margin: EdgeInsets.only(top: 1.h),
              child: KeysSaveDialogCopyViewSubtitle()),
          Container(
              padding: EdgeInsets.only(top: 5.h),
              child: KeysSaveDialogCopyViewFieldHeading()),
          Container(
              margin: EdgeInsets.only(top: 0.5.h),
              child: KeysSaveDialogCopyViewField(value: email, isEmail: true)),
          Container(
              margin: EdgeInsets.only(top: 1.h),
              child: KeysSaveDialogCopyViewField(
                  value: combinedKey, isEmail: false)),
          Container(
              margin: EdgeInsets.only(top: 6.h),
              child: KeysSaveDialogCopyViewButton())
        ]));
  }
}
