/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app_stash/src/platform/platform_relative_size.dart';
import 'package:app_stash/src/platform/platform_scaffold.dart';
import 'package:app_stash/src/ui/ui_big_button.dart';
import 'package:app_stash/src/ui/ui_dots.dart';
import 'package:app_stash/src/ui/ui_intro_skip.dart';
import 'package:app_stash/src/ui/ui_intro_subtitle.dart';
import 'package:app_stash/src/ui/ui_intro_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ScreenIntroAbstract extends PlatformScaffold {
  static final double _marginVerticalText =
      2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalButton =
      5 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalTitle =
      20 * PlatformRelativeSize.blockVertical;
  static final double _marginVerticalSkip =
      8 * PlatformRelativeSize.blockVertical;
  static final double _buttonWidth = 50 * PlatformRelativeSize.blockHorizontal;

  static const int screenTotal = 3;
  final Widget skipTo = Text("no");

  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String button;
  final int screenPos;

  ScreenIntroAbstract(this.backgroundColor, this.title, this.subtitle,
      this.button, this.screenPos);

  @override
  CupertinoPageScaffold iosScaffold(BuildContext context) {
    return CupertinoPageScaffold(child: screen(context));
  }

  @override
  Scaffold androidScaffold(BuildContext context) {
    return Scaffold(body: screen(context));
  }

  Widget screen(BuildContext context) {
    return GestureDetector(
        child: Stack(children: [_background(), _foreground(context)]),
        onHorizontalDragEnd: (dragEndDetails) =>
            onHorizontalDrag(context, dragEndDetails));
  }

  Widget _background() {
    return Stack(children: [
      Center(child: Container(color: backgroundColor)),
      Align(
          alignment: Alignment.bottomLeft,
          child: Image(image: AssetImage('res/image/intro-blob.png'))),
      Align(
          alignment: Alignment.bottomRight,
          child: Image(image: AssetImage('res/image/intro-pineapple.png'))),
    ]);
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: _marginVerticalSkip),
                    alignment: Alignment.topRight,
                    child: UiIntroSkip(skipTo)),
                Container(
                    margin: EdgeInsets.only(top: _marginVerticalTitle),
                    alignment: Alignment.centerLeft,
                    child: UiIntroTitle(title)),
                Container(
                    margin: EdgeInsets.only(top: _marginVerticalText),
                    child: UiIntroSubtitle(subtitle)),
                Container(
                    margin: EdgeInsets.only(top: _marginVerticalText),
                    child: UiDots(screenTotal, screenPos)),
                Container(
                    margin: EdgeInsets.only(top: _marginVerticalButton),
                    alignment: Alignment.centerLeft,
                    child: UiBigButton(button, onButtonPressed,
                        fixedWidth: _buttonWidth))
              ])))
    ]);
  }

  void onButtonPressed(BuildContext context);

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails);
}
