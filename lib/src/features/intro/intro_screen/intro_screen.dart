/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_dots.dart';
import 'package:app/src/widgets/components/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text_button.dart';
import 'package:app/src/widgets/components/tiki_title.dart';
import 'package:app/src/widgets/screens/background.dart';
import 'package:app/src/widgets/screens/foreground.dart';
import 'package:flutter/material.dart';

abstract class IntroScreen extends StatelessWidget {
  static final double _marginTopText = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopButton = 5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopTitle = 20 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSkip = 8 * PlatformRelativeSize.blockVertical;

  static const int screenTotal = 3;
  final String skipToPath = ConfigNavigate.path.loginEmail;

  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String button;
  final int screenPos;

  IntroScreen(this.backgroundColor, this.title, this.subtitle, this.button,
      this.screenPos);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            child:
                Stack(children: [_background(context), _foreground(context)]),
            onHorizontalDragEnd: (dragEndDetails) =>
                onHorizontalDrag(context, dragEndDetails)));
  }

  Widget _background(BuildContext context) {
    return TikiBackground(
      backgroundColor: backgroundColor,
      bottomLeft: HelperImage('intro-blob'),
      bottomRight: HelperImage('intro-pineapple'),
    );
  }

  Widget _foreground(BuildContext context) {
    return TikiForeground(children: [
      Container(
          margin: EdgeInsets.only(top: _marginTopSkip),
          alignment: Alignment.topRight,
          child: TikiTextButton(
            "Skip",
            _skipFunction,
            fontWeight: FontWeight.bold,
            fontSize: 4,
          )),
      Container(
          margin: EdgeInsets.only(top: _marginTopTitle),
          alignment: Alignment.centerLeft,
          child: TikiTitle(title)),
      Container(
          margin: EdgeInsets.only(top: _marginTopText),
          child: TikiSubtitle(subtitle)),
      Container(
          margin: EdgeInsets.only(top: _marginTopText),
          child: TikiDots(screenTotal, screenPos)),
      Container(
          margin: EdgeInsets.only(top: _marginTopButton),
          alignment: Alignment.centerLeft,
          child: TikiBigButton(button, true, onButtonPressed)),
    ]);
  }

  void onButtonPressed(BuildContext context);

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails);

  _skipFunction(context) {
    Navigator.of(context).pushNamed(skipToPath);
  }
}
