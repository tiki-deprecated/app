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
  static final double _marginTopTitle = 4.h;
  static final double _marginTopSubtitle = 2.5.h;
  static final double _marginTopScan = 2.5.h;
  static final double _marginHorizontalInput = 7.w;
  static final double _marginVerticalDivider = 5.h;
  static final double _marginTopSubmit = 5.h;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        alignment: Alignment.topLeft,
        child: KeysRestoreScreenViewBack(),
      ),
      Container(
          margin: EdgeInsets.only(top: _marginTopTitle),
          alignment: Alignment.center,
          child: KeysRestoreScreenViewTitle()),
      Container(
          margin: EdgeInsets.only(top: _marginTopSubtitle),
          alignment: Alignment.center,
          child: KeysRestoreScreenViewSubtitle()),
      Container(
          margin: EdgeInsets.symmetric(horizontal: _marginHorizontalInput),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: _marginTopScan),
              alignment: Alignment.center,
              child: KeysRestoreScreenViewScan(),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: _marginVerticalDivider),
                child: KeysRestoreScreenViewDivider()),
            Container(child: KeysRestoreScreenViewInput()),
            Container(
                margin: EdgeInsets.only(top: _marginTopSubmit),
                child: KeysRestoreScreenViewSubmit())
          ]))
    ])));
  }
}
