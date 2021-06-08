/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/new_src/use_cases/intro_screen/intro_screen_controller.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:app/src/widgets/components/tiki_dots.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_big_button.dart';
import 'package:app/src/widgets/components/tiki_inputs/tiki_text_button.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_subtitle.dart';
import 'package:app/src/widgets/components/tiki_text/tiki_title.dart';
import 'package:flutter/material.dart';
import '../res/intro_slides_strings.dart' as introSlidesStrings;

class IntroScreen extends StatelessWidget {
  static final double _marginTopText = 2.5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopButton = 5 * PlatformRelativeSize.blockVertical;
  static final double _marginTopTitle = 15 * PlatformRelativeSize.blockVertical;
  static final double _marginTopSkip = 2 * PlatformRelativeSize.blockVertical;
  static final double _marginRightText = 10 * PlatformRelativeSize.blockHorizontal;

  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String button;
  final IntroScreenController controller;
  final int totalSlides;
  final int currentSlide;

  IntroScreen({
        required this.controller,
        required this.backgroundColor,
        required this.title,
        required this.subtitle,
        required this.button,
        required this.totalSlides,
        required this.currentSlide
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                child: Stack(
                    children: [
                      Center(child: Container(color: this.backgroundColor)),
                      Align(alignment: Alignment.bottomLeft,
                        child: HelperImage('intro-blob'),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: HelperImage('intro-pineapple')
                      ),
                      SafeArea(
                          child: _foreground(context)
                      )
                    ]),
                onHorizontalDragEnd: (dragEndDetails) =>
                this.controller.onHorizontalDrag(context, dragEndDetails))));
  }

  Widget _foreground(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: _marginTopSkip),
          alignment: Alignment.topRight,
          child: TikiTextButton(
            introSlidesStrings.skip,
            this.controller.skipToLogin,
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
          child: TikiDots(this.totalSlides, this.currentSlide)),
      Container(
          margin: EdgeInsets.only(top: _marginTopButton),
          alignment: Alignment.centerLeft,
          child: TikiBigButton(
            button,
            true,
            this.controller.navigateToNextScreen,
            textWidth: 65,
          )),
    ]);
  }
}
