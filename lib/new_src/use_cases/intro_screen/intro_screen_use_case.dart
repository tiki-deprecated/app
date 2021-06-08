import 'package:app/src/config/config_navigate.dart';
import 'package:flutter/material.dart';

import '../../use_case.dart';
import 'intro_screen_controller.dart';
import 'model/intro_screen_model.dart';
import 'intro_screen_presenter.dart';
import 'model/intro_slide_model.dart';
import 'res/intro_slides_strings.dart' as introSlidesStrings;
import 'res/intro_slides_colors.dart' as introSlidesColors;

class IntroScreenUseCase extends UseCase {
  late IntroScreenPresenter _presenter;
  late IntroScreenModel _model;
  late IntroScreenController _controller;

  IntroScreenUseCase() {
    _presenter = IntroScreenPresenter();
    _model = IntroScreenModel();
    _controller = IntroScreenController(this);
    this.createSlidesData();
  }

  /// Creates the [IntroScreenModel]s
  ///
  /// Creates the [IntroSlideModel]s that will be used in [IntroScreenModel].
  createSlidesData(){
    introSlidesStrings.slides.toList().asMap().forEach((index, strings) {
      var slide = IntroSlideModel(
          title: strings['title'],
          subtitle: strings['subtitle'],
          button: strings['button'],
          backgroundColor: introSlidesColors.colors[index]
      );
      _model.addSlide(slide);
    });
  }

  getUI(){
    return _presenter.render(
      _controller,
      _model
    );
  }

  void moveToNextScreen(context) {
    _model.moveToNextSlide();
    var slider = this.getUI();
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
        slider,
        transitionDuration: Duration(seconds: 0),
        reverseTransitionDuration: Duration(seconds: 0)));
  }

  void skipToLogin(context) {
    Navigator.of(context).pushNamed(ConfigNavigate.path.loginEmail);
  }

  bool isLastSlide() {
    return _model.getCurrentSlideIndex() == _model.getTotalSlides();
  }
}




