import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_view_back.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_view_divider.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_view_input.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_view_scan.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_view_submit.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_view_subtitle.dart';
import 'package:app/src/slices/keys_restore_screen/ui/keys_restore_screen_view_title.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KeysRestoreScreenLayoutForeground extends StatelessWidget {
  static final double _marginVerticalDivider = 5.h;
  static final double _marginTopSubmit = 5.h;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        alignment: Alignment.topLeft,
        child: KeysRestoreScreenViewBack(),
      ),
      SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
            margin: EdgeInsets.only(top: 6.h),
            alignment: Alignment.center,
            child: KeysRestoreScreenViewTitle()),
        Container(
            margin: EdgeInsets.only(top: 2.h, left: 10.w, right: 10.w),
            alignment: Alignment.center,
            child: KeysRestoreScreenViewSubtitle()),
        Container(
          margin: EdgeInsets.only(top: 3.h, left: 15.w, right: 15.w),
          alignment: Alignment.center,
          child: KeysRestoreScreenViewScan(),
        ),
        Container(
            margin: EdgeInsets.only(top: 3.h, left: 15.w, right: 15.w),
            child: KeysRestoreScreenViewDivider()),
        Container(
            margin: EdgeInsets.only(top: 3.h, left: 15.w, right: 15.w),
            child: KeysRestoreScreenViewInput()),
        Container(
            margin: EdgeInsets.only(top: 3.h, left: 15.w, right: 15.w),
            child: KeysRestoreScreenViewSubmit())
      ]))
    ]));
  }
}
