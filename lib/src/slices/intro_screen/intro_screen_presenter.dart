import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intro_screen_service.dart';
import 'res/intro_slides_strings.dart' as introStrings;
import 'ui/intro_screen_layout.dart';

class IntroScreenPresenter extends Page {
  final IntroScreenService service;

  IntroScreenPresenter(this.service);

  get textSkip => introStrings.skip;

  num get fontSizeSkip => 15;

  num get fontSizeTitle => 34;

  num get fontSizeSubtitle => 15;

  num get fontSizeButton => 15;

  num get marginSkipTop => 2;

  num get marginTitleTop => 15;

  num get marginTextTop => 2;

  num get marginTextRight => 12;

  num get marginButtonTop => 5;

  num get marginHorizontal => 6;

  get textButton => introStrings.slides[currentSlideIndex]["button"];

  get textSubtitle => introStrings.slides[currentSlideIndex]["subtitle"];

  get currentSlideIndex => service.model.getCurrentSlideIndex();

  get textTitle => introStrings.slides[currentSlideIndex]["title"];

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) =>
            ChangeNotifierProvider.value(value: service, child: IntroScreen()));
  }
}
