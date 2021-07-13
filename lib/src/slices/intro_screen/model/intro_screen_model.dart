import 'intro_screen_model_slide.dart';

class IntroScreenModel {
  final List<IntroScreenModelSlide> _slides = [];
  bool shouldMoveToLogin = false;
  int _currentSlide = 0;

  void addSlide(IntroScreenModelSlide slide) {
    _slides.add(slide);
  }

  IntroScreenModelSlide getSlideAt(int index) {
    return _slides[index];
  }

  IntroScreenModelSlide getCurrentSlide() {
    return _slides[_currentSlide];
  }

  int getCurrentSlideIndex() {
    return _currentSlide;
  }

  IntroScreenModelSlide moveToNextSlide() {
    return _slides[++_currentSlide];
  }

  IntroScreenModelSlide moveToPreviousSlide() {
    return _slides[--_currentSlide];
  }

  int getTotalSlides() {
    return _slides.length;
  }
}
