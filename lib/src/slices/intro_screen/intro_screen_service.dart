import 'package:app/src/slices/login_screen/login_screen_service.dart';
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
    controller = IntroScreenController();
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

  getUI() {
    return presenter.render();
  }

  void moveToNextScreen(context) {
    model.moveToNextSlide();
    var slider = this.getUI();
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => slider,
        transitionDuration: Duration(seconds: 0),
        reverseTransitionDuration: Duration(seconds: 0)));
    notifyListeners();
  }

  void moveToPreviousScreen(context) {
    model.moveToPreviousSlide();
    var slider = this.getUI();
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => slider,
        transitionDuration: Duration(seconds: 0),
        reverseTransitionDuration: Duration(seconds: 0)));
    notifyListeners();
  }

  void skipToLogin(context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreenService().getUI()),
      ModalRoute.withName('/login'),
    );
  }

  bool isLastSlide() {
    return model.getCurrentSlideIndex() == (model.getTotalSlides() - 1);
  }

  bool isFirstSlide() {
    return model.getCurrentSlideIndex() == 0;
  }
}
