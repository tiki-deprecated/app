import 'package:flutter/material.dart';

import 'intro_screen_controller.dart';
import 'intro_screen_presenter.dart';
import 'model/intro_screen_model.dart';
import 'model/intro_screen_model_slide.dart';
import 'res/intro_slides_colors.dart' as introSlidesColors;
import 'res/intro_slides_strings.dart' as introSlidesStrings;

/// The Intro Screen for the first time the app is opened in the device.
class IntroScreenService extends ChangeNotifier {
  late IntroScreenPresenter presenter;
  late IntroScreenModel model;
  late IntroScreenController controller;

  IntroScreenService() {
    presenter = IntroScreenPresenter(this);
    model = IntroScreenModel();
    controller = IntroScreenController(this);
    this.createSlidesData();
  }

  /// Creates the [IntroScreenModel]s
  ///
  /// Creates the [IntroSlideModel]s that will be used in [IntroScreenModel].
  createSlidesData() {
    introSlidesStrings.slides.toList().asMap().forEach((index, strings) {
      var slide = IntroScreenModelSlide(
          title: strings['title'],
          subtitle: strings['subtitle'],
          button: strings['button'],
          backgroundColor: introSlidesColors.colors[index]);
      model.addSlide(slide);
    });
    notifyListeners();
  }

  void moveToNextScreen() {
    model.moveToNextSlide();
    notifyListeners();
  }

  void moveToPreviousScreen() {
    model.moveToPreviousSlide();
    notifyListeners();
  }

  void skipToLogin() {
    model.shouldMoveToLogin = true;
    notifyListeners();
  }

  bool isLastSlide() {
    return model.getCurrentSlideIndex() == (model.getTotalSlides() - 1);
  }

  bool isFirstSlide() {
    return model.getCurrentSlideIndex() == 0;
  }
}
