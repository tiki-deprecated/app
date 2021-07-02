/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/keys_create_screen/ui/keys_create_screen_view_restore.dart';
import 'package:app/src/slices/keys_create_screen/ui/keys_create_screen_view_subtitle.dart';
import 'package:app/src/slices/keys_create_screen/ui/keys_create_screen_view_title.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class KeysCreateScreenLayoutForeground extends StatelessWidget {
  static final double _marginTopTitle = 5.h;
  static final double _marginTopSubtitle = 2.h;
  static final double _marginBottomButton = 4.h;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _foreground(context));
  }

  Widget _foreground(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(top: _marginTopTitle),
                  child: KeysCreateScreenViewTitle()),
              Container(
                  margin: EdgeInsets.only(top: _marginTopSubtitle),
                  child: KeysCreateScreenViewSubtitle()),
            ],
          )
        ],
      ),
      Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: ClipRect(
              child: Align(
                  alignment: Alignment.center,
                  heightFactor: 0.5,
                  child: Lottie.asset(
                      "res/animation/Securing_account_with_blob.json")),
            ),
          ),
        ],
      )),
      Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: _marginBottomButton),
          child: KeysCreateScreenViewRestore()),
    ]);
  }
}
