/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/tiki_big_button.dart';
import 'package:app/src/widgets/tiki_text_button.dart';
import 'package:app/src/widgets/tiki_dots.dart';
import 'package:app/src/widgets/tiki_subtitle.dart';
import 'package:app/src/widgets/tiki_title.dart';
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
            child: Stack(children: [_background(), _foreground(context)]),
            onHorizontalDragEnd: (dragEndDetails) =>
                onHorizontalDrag(context, dragEndDetails))
    );
  }

  Widget _background() {
    return Stack(children: [
      Center(child: Container(color: backgroundColor)),
      Align(alignment: Alignment.bottomLeft, child: HelperImage('intro-blob')),
      Align(
          alignment: Alignment.bottomRight,
          child: HelperImage('intro-pineapple')),
    ]);
  }

  Widget _foreground(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: PlatformRelativeSize.marginHorizontal2x),
              child: Column(children: [
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
                    child: TikiBigButton(button, true, onButtonPressed))
              ])))
    ]);
  }

  void onButtonPressed(BuildContext context);

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails);


  _skipFunction(context) {
      Navigator.of(context).pushNamed(skipToPath);
  }
}
