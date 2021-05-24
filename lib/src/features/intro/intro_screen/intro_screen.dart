/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_navigate.dart';
import 'package:app/src/utils/analytics/tiki_analytics.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_dots.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_text_button.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:app/src/widgets/screens/tiki_background.dart';
import 'package:app/src/widgets/screens/tiki_scaffold.dart';
import 'package:flutter/material.dart';

abstract class IntroScreen extends StatelessWidget {
  static final double _marginTopText = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopButton = 5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSkip = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginRightText =
      10 * PlatformRelativeSize.blockHorizontal;

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
    TikiBackground background = TikiBackground(
        backgroundColor: backgroundColor,
        bottomLeft: HelperImage('intro-blob'),
        bottomRight: HelperImage('intro-pineapple'));

    return TikiScaffold(
      background: background,
      foregroundChildren: _foreground(context),
      onHorizontalDrag: onHorizontalDrag,
    );
  }

  List<Widget> _foreground(BuildContext context) {
    return <Widget>[
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
          margin:
              EdgeInsets.only(top: _marginTopTitle, right: _marginRightText),
          alignment: Alignment.centerLeft,
          child: TikiTitle(
            title,
            textAlign: TextAlign.left,
          )),
      Container(
          margin: EdgeInsets.only(top: _marginTopText, right: _marginRightText),
          child: TikiSubtitle(subtitle, textAlign: TextAlign.left)),
      Container(
          margin: EdgeInsets.only(top: _marginTopText, right: _marginRightText),
          alignment: Alignment.centerLeft,
          child: TikiDots(screenTotal, screenPos)),
      Container(
          margin: EdgeInsets.only(top: _marginTopButton),
          alignment: Alignment.centerLeft,
          child: TikiBigButton(
            button,
            true,
            onButtonPressed,
            textWidth: 45,
          )),
    ];
  }

  void onButtonPressed(BuildContext context);

  void onHorizontalDrag(BuildContext context, DragEndDetails dragEndDetails);

  _skipFunction(context) {
    TikiAnalytics.getLogger()!.logEvent('INTRO_SKIPPED');
    Navigator.of(context).pushNamed(skipToPath);
  }
}
