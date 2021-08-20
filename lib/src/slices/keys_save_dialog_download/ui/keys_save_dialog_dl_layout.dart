/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';
import 'keys_save_dialog_dl_button.dart';
import 'keys_save_dialog_dl_view_qr.dart';
import 'keys_save_dialog_dl_view_subtitle.dart';
import 'keys_save_dialog_dl_view_title.dart';
import 'keys_save_dialog_dl_view_warning.dart';

class KeysSaveDialogDlLayout extends StatelessWidget {
  final String combinedKey;
  final GlobalKey repaintKey;

  KeysSaveDialogDlLayout({required this.combinedKey, required this.repaintKey});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        titlePadding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w),
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 4.h),
        title: KeysSaveDialogDlViewTitle(),
        content: RepaintBoundary(
          key: repaintKey,
          child: Container(
              color: ConfigColor.white,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    margin: EdgeInsets.only(top: 1.h),
                    child: KeysSaveDialogDlViewSubtitle()),
                Container(
                    margin: EdgeInsets.only(top: 1.h),
                    child: KeysSaveDialogDlViewWarning()),
                Container(
                    margin: EdgeInsets.only(top: 2.h),
                    child: KeysSaveDialogDlViewQr(combinedKey)),
                Container(
                    margin: EdgeInsets.only(top: 3.h),
                    child: KeysSaveDialogDlViewButton(repaintKey: repaintKey))
              ])),
        ));
  }
}
