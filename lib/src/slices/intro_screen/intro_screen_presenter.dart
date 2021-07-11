import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intro_screen_service.dart';
import 'res/intro_slides_strings.dart' as introStrings;
import 'ui/intro_screen_layout.dart';

class IntroScreenPresenter extends Page {
  final IntroScreenService service;

  IntroScreenPresenter(this.service);

  get textSkip => introStrings.skip;

  get textButton => introStrings.slides[currentSlideIndex]["button"];

  get textSubtitle => introStrings.slides[currentSlideIndex]["subtitle"];

  get currentSlideIndex => service.model.getCurrentSlideIndex();

  get textTitle => introStrings.slides[currentSlideIndex]["title"];

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
            value: service, child: IntroScreen());
      },
    );
  }
}
